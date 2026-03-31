#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Setup Copilot CLI with marketplaces, plugins, and skills
"$SCRIPT_DIR/scripts/setup-copilot.sh"
