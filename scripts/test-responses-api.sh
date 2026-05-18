#!/usr/bin/env bash
# Test script for copilot-api PR #170 (responses-api support)
# Tests Codex models (gpt-*-codex) via /responses endpoint

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_TOTAL=0

# Results directory
RESULTS_DIR="debug-responses-api"
mkdir -p "$RESULTS_DIR"
RESULTS_FILE="$RESULTS_DIR/test-results-$(date +%Y%m%d-%H%M%S).txt"

log() {
    echo -e "${BLUE}[$(date +%H:%M:%S)]${NC} $*" | tee -a "$RESULTS_FILE"
}

log_success() {
    echo -e "${GREEN}✅ $*${NC}" | tee -a "$RESULTS_FILE"
    ((TESTS_PASSED++))
}

log_fail() {
    echo -e "${RED}❌ $*${NC}" | tee -a "$RESULTS_FILE"
    ((TESTS_FAILED++))
}

log_warn() {
    echo -e "${YELLOW}⚠️  $*${NC}" | tee -a "$RESULTS_FILE"
}

run_test() {
    local test_name="$1"
    local model="$2"
    local prompt="$3"
    local expected_pattern="${4:-}"

    ((TESTS_TOTAL++))
    log "\n=========================================="
    log "Test #$TESTS_TOTAL: $test_name"
    log "Model: $model"
    log "Prompt: $prompt"
    log "==========================================\n"

    local output_file="$RESULTS_DIR/test-${TESTS_TOTAL}-output.txt"
    local exit_code=0

    # Run test and capture output
    if COPILOT_MODEL="$model" timeout 60s claude-switch copilot -p "$prompt" > "$output_file" 2>&1; then
        exit_code=0
    else
        exit_code=$?
    fi

    # Check result
    if [ $exit_code -eq 0 ]; then
        if [ -n "$expected_pattern" ]; then
            if grep -q "$expected_pattern" "$output_file"; then
                log_success "$test_name PASSED (found expected pattern: $expected_pattern)"
            else
                log_fail "$test_name FAILED (pattern not found: $expected_pattern)"
                log "Output preview: $(head -5 "$output_file")"
            fi
        else
            log_success "$test_name PASSED (no error)"
        fi
    else
        log_fail "$test_name FAILED (exit code: $exit_code)"
        log "Error output: $(tail -10 "$output_file")"
    fi

    log "Full output saved to: $output_file"
}

# Pre-flight checks
log "=========================================="
log "Pre-flight Checks"
log "=========================================="

# Check if copilot-api is running
if ! nc -z localhost 4141 2>/dev/null; then
    log_fail "copilot-api not running on port 4141"
    log "Please start the fork first:"
    log "  cd ~/src/copilot-api-responses"
    log "  bun run start start -v"
    exit 1
fi

log_success "copilot-api responding on port 4141"

# Check if it's the fork version
log "Checking if fork version is running..."
log_warn "Manual verification needed: check logs for '/responses' endpoint support"

log "\n=========================================="
log "Starting Tests"
log "=========================================="

# Phase 1: Basic Codex models
log "\n=== PHASE 1: Basic Codex Model Tests ==="

run_test "Codex Premium (5.2)" "gpt-5.2-codex" "1+1" ""
run_test "Codex Standard (5.1)" "gpt-5.1-codex" "Hello world" ""
run_test "Codex Mini" "gpt-5.1-codex-mini" "Hello" ""
run_test "Codex Max" "gpt-5.1-codex-max" "2+2" ""

# Phase 2: Regression tests (non-Codex should still work)
log "\n=== PHASE 2: Regression Tests (Non-Codex) ==="

run_test "GPT-5 (non-Codex)" "gpt-5" "1+1" ""
run_test "Claude Sonnet" "claude-sonnet-4-6" "Hello" ""

# Phase 3: Agentic capabilities
log "\n=== PHASE 3: Agentic Tests ==="

# Test 3.1: File creation
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"
run_test "File Creation" "gpt-5.2-codex" "Create a file test-responses-api.txt with content 'Codex test'" "test-responses-api.txt"

if [ -f "test-responses-api.txt" ]; then
    log_success "File test-responses-api.txt was created"
    log "Content: $(cat test-responses-api.txt)"
else
    log_fail "File test-responses-api.txt was NOT created"
fi

# Test 3.2: Tool calling (grep)
cd ~/Sites/perso/cc-copilot-bridge
run_test "Tool Calling (grep)" "gpt-5.2-codex" "Use grep to find the word 'copilot-api' in README.md" "copilot-api"

# Test 3.3: Multi-step reasoning
run_test "Multi-step Reasoning" "gpt-5.2-codex" "Read the first 3 lines of README.md and tell me the project name" "claude-switch"

# Cleanup
rm -rf "$TEMP_DIR"

# Summary
log "\n=========================================="
log "Test Summary"
log "=========================================="
log "Total tests: $TESTS_TOTAL"
log_success "Passed: $TESTS_PASSED"
log_fail "Failed: $TESTS_FAILED"

if [ $TESTS_FAILED -eq 0 ]; then
    log_success "\n🎉 All tests passed! PR #170 is working correctly."
    exit 0
else
    log_fail "\n❌ Some tests failed. Review results in $RESULTS_DIR/"
    exit 1
fi
