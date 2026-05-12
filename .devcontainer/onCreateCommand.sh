#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bash "$SCRIPT_DIR/scripts/setup-copilot.sh"
bash "$SCRIPT_DIR/scripts/setup-rtk.sh"