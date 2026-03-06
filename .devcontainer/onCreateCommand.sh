#!/bin/bash
set -e

# ============================================================================
# CONFIGURATION - Modify these to add/remove marketplaces and plugins
# ============================================================================

# Define custom marketplaces and their repository locations
# Format: [marketplace-name]="owner/repo"
# Note: awesome-copilot and copilot-plugins are included by default
declare -A MARKETPLACE_REPOS=(
    [claude-plugins-official]="anthropics/claude-plugins-official"
    [microsoft-docs-marketplace]="microsoftdocs/mcp"
)

# Define plugins organized by marketplace
# Format: [marketplace-name]="plugin1 plugin2 plugin3"
declare -A PLUGINS=(
    [claude-plugins-official]="context7 feature-dev code-review code-simplifier frontend-design skill-creator"
    [microsoft-docs-marketplace]="microsoft-docs"
)

# ============================================================================
# ANSI color codes - dark terminal friendly & colorblind accessible
# Using bright colors for dark terminals, avoiding red-green for colorblind users
BOLD='\033[1m'
BRIGHT_CYAN='\033[1;36m'
BRIGHT_WHITE='\033[1;37m'
DIM='\033[2;37m'
NC='\033[0m' # No Color

# Add yolo alias for Copilot AI (full permissions mode)
echo 'alias yolo="copilot --allow-all --model claude-haiku-4.5"' >> ~/.bashrc
echo -e "${BRIGHT_CYAN}✓${NC} Added yolo alias"

# Add custom marketplaces
for marketplace_name in "${!MARKETPLACE_REPOS[@]}"; do
    repo="${MARKETPLACE_REPOS[$marketplace_name]}"
    echo -e "${DIM}[marketplace]${NC} ${BRIGHT_CYAN}$marketplace_name${NC} ${DIM}($repo)${NC}"
    copilot plugin marketplace add "$repo"
done

# Install plugins grouped by marketplace
for marketplace_name in "${!PLUGINS[@]}"; do
    plugins="${PLUGINS[$marketplace_name]}"
    echo ""
    echo -e "${DIM}[plugins]${NC} ${BRIGHT_CYAN}$marketplace_name${NC}"
    for plugin in $plugins; do
        echo -e "  ${BRIGHT_WHITE}▶${NC} $plugin ${DIM}@ $marketplace_name${NC}"
        copilot plugin install "$plugin@$marketplace_name"
    done
done
