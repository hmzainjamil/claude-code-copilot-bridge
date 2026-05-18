#!/usr/bin/env bash
# Helper script to launch copilot-api fork with responses-api support
# Ensures clean environment and proper setup

set -euo pipefail

FORK_DIR="$HOME/src/copilot-api-responses"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}=========================================="
echo "Launching copilot-api fork (PR #170)"
echo -e "==========================================${NC}\n"

# Step 0: Check if PR #170 is merged
echo -e "${YELLOW}[0/6] Checking PR #170 status...${NC}"
PR_STATUS=$(curl -s https://api.github.com/repos/ericc-ch/copilot-api/pulls/170 | grep '"merged"' | head -1 | grep -o 'true\|false' || echo "unknown")

if [ "$PR_STATUS" = "true" ]; then
    echo -e "${GREEN}✅ PR #170 is MERGED into official copilot-api!${NC}\n"
    echo -e "${YELLOW}╔════════════════════════════════════════════════════════════════╗"
    echo -e "║  ⚠️  WARNING: This fork is no longer necessary!               ║"
    echo -e "╚════════════════════════════════════════════════════════════════╝${NC}\n"
    echo -e "${GREEN}The Codex models support (/responses endpoint) is now available"
    echo -e "in the official copilot-api package.${NC}\n"
    echo -e "${YELLOW}What to do:${NC}"
    echo -e "  1. Stop this fork (if running): ${GREEN}pkill -f 'copilot-api'${NC}"
    echo -e "  2. Update official copilot-api: ${GREEN}npm update -g copilot-api${NC}"
    echo -e "  3. Start official version: ${GREEN}copilot-api start${NC}"
    echo -e "  4. Test Codex models: ${GREEN}COPILOT_MODEL=gpt-5.2-codex ccc -p 'Test'${NC}\n"
    echo -e "${YELLOW}Benefits of using official version:${NC}"
    echo -e "  ✅ Automatic updates via npm"
    echo -e "  ✅ Bug fixes and improvements"
    echo -e "  ✅ Community support"
    echo -e "  ✅ No need to maintain fork\n"
    echo -e "${YELLOW}Continue launching fork anyway? (y/N)${NC} "
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo -e "\n${GREEN}Aborted. Please update to official version.${NC}"
        exit 0
    fi
    echo ""
elif [ "$PR_STATUS" = "false" ]; then
    echo -e "${YELLOW}⏳ PR #170 is still pending (not merged yet)${NC}"
    echo -e "   This fork is needed to use Codex models.\n"
elif [ "$PR_STATUS" = "unknown" ]; then
    echo -e "${YELLOW}⚠️  Could not check PR status (network issue or API rate limit)${NC}"
    echo -e "   Proceeding with fork launch...\n"
fi

# Step 1: Check if official copilot-api is running
echo -e "${YELLOW}[1/6] Checking for conflicting processes...${NC}"
if lsof -i :4141 > /dev/null 2>&1; then
    echo -e "${RED}⚠️  Port 4141 is already in use!${NC}"
    echo "Please stop the official copilot-api first:"
    echo "  pkill -f 'copilot-api'"
    echo ""
    lsof -i :4141
    exit 1
else
    echo -e "${GREEN}✅ Port 4141 is free${NC}"
fi

# Step 2: Check fork directory
echo -e "\n${YELLOW}[2/6] Checking fork directory...${NC}"
if [ ! -d "$FORK_DIR" ]; then
    echo -e "${RED}❌ Fork directory not found: $FORK_DIR${NC}"
    echo "Please clone it first:"
    echo "  git clone https://github.com/caozhiyuan/copilot-api.git ~/src/copilot-api-responses"
    echo "  cd ~/src/copilot-api-responses"
    echo "  git checkout feature/responses-api"
    exit 1
else
    echo -e "${GREEN}✅ Fork directory exists${NC}"
fi

cd "$FORK_DIR"

# Step 3: Verify branch
echo -e "\n${YELLOW}[3/6] Checking branch...${NC}"
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "feature/responses-api" ]; then
    echo -e "${RED}❌ Wrong branch: $CURRENT_BRANCH${NC}"
    echo "Please checkout feature/responses-api:"
    echo "  cd $FORK_DIR"
    echo "  git checkout feature/responses-api"
    exit 1
else
    echo -e "${GREEN}✅ On branch: feature/responses-api${NC}"
fi

# Step 4: Check build
echo -e "\n${YELLOW}[4/6] Checking build...${NC}"
if [ ! -f "dist/main.js" ]; then
    echo -e "${YELLOW}⚠️  Build not found, building now...${NC}"
    export PATH="$HOME/.bun/bin:$PATH"
    bun run build
else
    echo -e "${GREEN}✅ Build exists${NC}"
fi

# Step 5: Launch
echo -e "\n${YELLOW}[5/6] Launching copilot-api fork with verbose logging...${NC}\n"
echo -e "${GREEN}================================================"
echo "copilot-api fork is starting..."
echo "Press Ctrl+C to stop"
echo -e "================================================${NC}\n"

export PATH="$HOME/.bun/bin:$PATH"
exec bun run start start -v
