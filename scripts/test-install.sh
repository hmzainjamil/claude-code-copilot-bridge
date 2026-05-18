#!/bin/bash
# Test the interactive installer behavior
# Usage: ./scripts/test-install.sh

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

TEMP_HOME=$(mktemp -d)
export HOME="$TEMP_HOME"

echo "Testing installer in temp home: $TEMP_HOME"
echo ""

# Test 1: Auto mode (choice 1)
echo -e "${BLUE}Test 1: Auto mode (modifies .zshrc)${NC}"
echo ""

cat > "$TEMP_HOME/.zshrc" << 'EOF'
# Existing config
export PATH="/usr/local/bin:$PATH"
EOF

echo "1" | ./install.sh > /dev/null 2>&1

if grep -q "source ~/.claude/aliases.sh" "$TEMP_HOME/.zshrc"; then
    echo -e "${GREEN}✓ Auto mode: Modified .zshrc correctly${NC}"
else
    echo -e "${RED}✗ Auto mode: Failed to modify .zshrc${NC}"
    exit 1
fi

if [ -f "$TEMP_HOME/.claude/aliases.sh" ]; then
    echo -e "${GREEN}✓ Auto mode: Created aliases.sh${NC}"
else
    echo -e "${RED}✗ Auto mode: aliases.sh not created${NC}"
    exit 1
fi

# Cleanup
rm -rf "$TEMP_HOME"
TEMP_HOME=$(mktemp -d)
export HOME="$TEMP_HOME"

echo ""

# Test 2: Manual mode with confirmation (choice 2 + y)
echo -e "${BLUE}Test 2: Manual mode with confirmation${NC}"
echo ""

cat > "$TEMP_HOME/.zshrc" << 'EOF'
# Existing config
export PATH="/usr/local/bin:$PATH"
EOF

echo -e "2\ny" | ./install.sh > /dev/null 2>&1

if grep -q "source ~/.claude/aliases.sh" "$TEMP_HOME/.zshrc"; then
    echo -e "${RED}✗ Manual mode: Should NOT modify .zshrc${NC}"
    exit 1
else
    echo -e "${GREEN}✓ Manual mode: Did not modify .zshrc${NC}"
fi

if [ -f "$TEMP_HOME/.claude/aliases.sh" ]; then
    echo -e "${GREEN}✓ Manual mode: Created aliases.sh${NC}"
else
    echo -e "${RED}✗ Manual mode: aliases.sh not created${NC}"
    exit 1
fi

# Cleanup
rm -rf "$TEMP_HOME"
TEMP_HOME=$(mktemp -d)
export HOME="$TEMP_HOME"

echo ""

# Test 3: Manual mode without confirmation (choice 2 + n)
echo -e "${BLUE}Test 3: Manual mode without confirmation (warning)${NC}"
echo ""

cat > "$TEMP_HOME/.zshrc" << 'EOF'
# Existing config
export PATH="/usr/local/bin:$PATH"
EOF

echo -e "2\nn\n" | ./install.sh > /dev/null 2>&1

if [ -f "$TEMP_HOME/.claude/aliases.sh" ]; then
    echo -e "${GREEN}✓ Manual mode (no confirm): Created aliases.sh anyway${NC}"
else
    echo -e "${RED}✗ Manual mode (no confirm): aliases.sh not created${NC}"
    exit 1
fi

echo ""

# Test 4: Check aliases.sh content
echo -e "${BLUE}Test 4: Verify aliases.sh content${NC}"
echo ""

if grep -q "alias ccd=" "$TEMP_HOME/.claude/aliases.sh"; then
    echo -e "${GREEN}✓ Aliases: Contains ccd${NC}"
else
    echo -e "${RED}✗ Aliases: Missing ccd${NC}"
    exit 1
fi

if grep -q "alias ccc=" "$TEMP_HOME/.claude/aliases.sh"; then
    echo -e "${GREEN}✓ Aliases: Contains ccc${NC}"
else
    echo -e "${RED}✗ Aliases: Missing ccc${NC}"
    exit 1
fi

if grep -q "alias cco=" "$TEMP_HOME/.claude/aliases.sh"; then
    echo -e "${GREEN}✓ Aliases: Contains cco${NC}"
else
    echo -e "${RED}✗ Aliases: Missing cco${NC}"
    exit 1
fi

if grep -q "alias ccc-opus=" "$TEMP_HOME/.claude/aliases.sh"; then
    echo -e "${GREEN}✓ Aliases: Contains model shortcuts${NC}"
else
    echo -e "${RED}✗ Aliases: Missing model shortcuts${NC}"
    exit 1
fi

echo ""

# Test 5: Check that aliases file is sourceable
echo -e "${BLUE}Test 5: Verify aliases.sh is valid bash${NC}"
echo ""

if bash -n "$TEMP_HOME/.claude/aliases.sh"; then
    echo -e "${GREEN}✓ Aliases: Valid bash syntax${NC}"
else
    echo -e "${RED}✗ Aliases: Invalid bash syntax${NC}"
    exit 1
fi

# Cleanup
rm -rf "$TEMP_HOME"

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ All tests passed!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
