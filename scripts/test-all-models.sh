#!/usr/bin/env bash
# Test all available models via copilot-api
# Usage: ./scripts/test-all-models.sh

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=========================================="
echo "Testing All Copilot API Models"
echo -e "==========================================${NC}\n"

# Check if copilot-api is running
if ! nc -z localhost 4141 2>/dev/null; then
    echo -e "${RED}❌ copilot-api not running on port 4141${NC}"
    echo "Please start copilot-api first:"
    echo "  copilot-api start"
    echo "  OR"
    echo "  ./scripts/launch-unified-fork.sh (for Codex models)"
    exit 1
fi

echo -e "${GREEN}✅ copilot-api is running on port 4141${NC}\n"

# Test prompt
TEST_PROMPT="Calculate 1+1 and respond with just the number"

# Counter
TOTAL=0
PASSED=0
FAILED=0

test_model() {
    local model="$1"
    local category="${2:-General}"

    ((TOTAL++))
    echo -e "${BLUE}[Test $TOTAL]${NC} Testing: ${YELLOW}$model${NC} ($category)"

    if timeout 30s bash -c "COPILOT_MODEL=$model ccc -p '$TEST_PROMPT' > /dev/null 2>&1"; then
        echo -e "${GREEN}  ✅ PASS${NC}\n"
        ((PASSED++))
    else
        echo -e "${RED}  ❌ FAIL${NC}\n"
        ((FAILED++))
    fi
}

# GPT Codex Models (require PR #170 fork)
echo -e "${YELLOW}=== GPT Codex Models (Requires PR #170 Fork) ===${NC}\n"
test_model "gpt-5.2-codex" "Codex Premium"
test_model "gpt-5.1-codex" "Codex Standard"
test_model "gpt-5.1-codex-mini" "Codex Mini"
test_model "gpt-5.1-codex-max" "Codex Max"
test_model "gpt-5-codex" "Codex Legacy"

# GPT-5 Series
echo -e "${YELLOW}=== GPT-5 Series ===${NC}\n"
test_model "gpt-5.2" "GPT-5.2"
test_model "gpt-5.1" "GPT-5.1"
test_model "gpt-5" "GPT-5"
test_model "gpt-5-mini" "GPT-5 Mini"

# GPT-4 Series
echo -e "${YELLOW}=== GPT-4 Series ===${NC}\n"
test_model "gpt-4.1" "GPT-4.1 (0x premium)"
test_model "gpt-4.1-2025-04-14" "GPT-4.1 Dated"
test_model "gpt-41-copilot" "GPT-4.1 Copilot"
test_model "gpt-4o" "GPT-4o"
test_model "gpt-4o-2024-11-20" "GPT-4o Nov 2024"
test_model "gpt-4o-2024-08-06" "GPT-4o Aug 2024"
test_model "gpt-4o-2024-05-13" "GPT-4o May 2024"
test_model "gpt-4o-mini" "GPT-4o Mini"
test_model "gpt-4o-mini-2024-07-18" "GPT-4o Mini Jul 2024"
test_model "gpt-4-o-preview" "GPT-4o Preview"
test_model "gpt-4" "GPT-4"
test_model "gpt-4-0613" "GPT-4 Jun 2023"
test_model "gpt-4-0125-preview" "GPT-4 Jan 2025"

# GPT-3.5 Series
echo -e "${YELLOW}=== GPT-3.5 Series ===${NC}\n"
test_model "gpt-3.5-turbo" "GPT-3.5 Turbo"
test_model "gpt-3.5-turbo-0613" "GPT-3.5 Turbo Jun 2023"

# Claude Models
echo -e "${YELLOW}=== Claude Models ===${NC}\n"
test_model "claude-opus-4-6" "Claude Opus 4.6"
test_model "claude-opus-41" "Claude Opus 4.1"
test_model "claude-sonnet-4-6" "Claude Sonnet 4.6"
test_model "claude-sonnet-4" "Claude Sonnet 4"
test_model "claude-haiku-4.5" "Claude Haiku 4.5"

# Gemini Models
echo -e "${YELLOW}=== Gemini Models ===${NC}\n"
test_model "gemini-3-pro-preview" "Gemini 3 Pro Preview"
test_model "gemini-3-flash-preview" "Gemini 3 Flash Preview"
test_model "gemini-2.5-pro" "Gemini 2.5 Pro"

# Other Models
echo -e "${YELLOW}=== Other Models ===${NC}\n"
test_model "grok-code-fast-1" "Grok Code Fast"
test_model "oswe-vscode-prime" "OSWE VSCode Prime"

# Embedding Models (will likely fail with chat prompts)
echo -e "${YELLOW}=== Embedding Models (Expected to Fail) ===${NC}\n"
test_model "text-embedding-3-small" "Embedding Small"
test_model "text-embedding-3-small-inference" "Embedding Small Inference"
test_model "text-embedding-ada-002" "Embedding Ada"

# Summary
echo -e "${BLUE}=========================================="
echo "Test Summary"
echo -e "==========================================${NC}"
echo -e "Total tests: ${YELLOW}$TOTAL${NC}"
echo -e "Passed: ${GREEN}$PASSED${NC}"
echo -e "Failed: ${RED}$FAILED${NC}"

if [ $FAILED -eq 0 ]; then
    echo -e "\n${GREEN}🎉 All tests passed!${NC}"
    exit 0
else
    echo -e "\n${YELLOW}⚠️  Some models failed (may be expected for embeddings or unavailable models)${NC}"
    exit 0
fi
