#!/bin/bash
# TraceMem environment check utility
# Verifies that required environment variables are configured

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "TraceMem Environment Check"
echo "=========================="
echo ""

# Check TRACEMEM_API_KEY
if [ -z "${TRACEMEM_API_KEY:-}" ]; then
  echo -e "${RED}✗ TRACEMEM_API_KEY is not set${NC}"
  echo "  Set your API key with: export TRACEMEM_API_KEY=your_key_here"
  echo "  Or add it to your shell profile (~/.bashrc, ~/.zshrc)"
  EXIT_CODE=1
else
  # Show first 4 and last 4 characters only
  KEY_LEN=${#TRACEMEM_API_KEY}
  if [ "$KEY_LEN" -gt 8 ]; then
    MASKED="${TRACEMEM_API_KEY:0:4}...${TRACEMEM_API_KEY: -4}"
  else
    MASKED="****"
  fi
  echo -e "${GREEN}✓ TRACEMEM_API_KEY is set${NC} ($MASKED)"
  EXIT_CODE=0
fi

# Check TRACEMEM_MCP_URL (optional)
if [ -z "${TRACEMEM_MCP_URL:-}" ]; then
  echo -e "${YELLOW}○ TRACEMEM_MCP_URL is not set (using default: https://mcp.tracemem.com)${NC}"
else
  echo -e "${GREEN}✓ TRACEMEM_MCP_URL is set${NC} ($TRACEMEM_MCP_URL)"
fi

echo ""
exit ${EXIT_CODE:-0}
