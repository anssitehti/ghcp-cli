#!/bin/bash
set -euo pipefail

# ============================================================================
# ANSI color codes - dark terminal friendly & readable in logs
# ============================================================================

BRIGHT_CYAN='\033[1;36m'
BRIGHT_WHITE='\033[1;37m'
DIM='\033[2;37m'
NC='\033[0m' # No Color

echo -e "${BRIGHT_CYAN}==>${NC} Setting up rtk..."

if command -v rtk >/dev/null 2>&1; then
  echo -e "${DIM}[install]${NC} ${BRIGHT_CYAN}rtk${NC} ${DIM}already installed: $(rtk version 2>/dev/null | head -n 1)${NC}"
  exit 0
fi

echo -e "${DIM}[install]${NC} ${BRIGHT_CYAN}rtk${NC} ${DIM}installing from rtk-ai${NC}"
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh

if ! command -v rtk >/dev/null 2>&1; then
  echo "rtk installation finished, but the binary is not on PATH" >&2
  exit 1
fi

echo -e "${DIM}[init]${NC} ${BRIGHT_CYAN}rtk${NC} ${DIM}configuring...${NC}"
rtk telemetry forget
rtk init --global --copilot
rtk telemetry forget

echo -e "${BRIGHT_WHITE}✓${NC} rtk ready: $(rtk version 2>/dev/null | head -n 1)"