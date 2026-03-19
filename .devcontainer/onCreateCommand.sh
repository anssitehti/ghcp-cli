#!/bin/bash
set -euo pipefail

# ============================================================================
# CONFIGURATION - Modify these to add/remove marketplaces and plugins
# ============================================================================

# Define custom marketplaces and their repository locations
# Format: [marketplace-name]="owner/repo"
# Note: awesome-copilot and copilot-plugins are included by default
declare -A MARKETPLACE_REPOS=(
    #[claude-plugins-official]="anthropics/claude-plugins-official"
    [microsoft-docs-marketplace]="microsoftdocs/mcp"
    [fabric-collection]="microsoft/skills-for-fabric"
)

# Define plugins organized by marketplace
# Format: [marketplace-name]="plugin1 plugin2 plugin3"
declare -A PLUGINS=(
    [claude-plugins-official]="context7 feature-dev code-review code-simplifier frontend-design skill-creator"
    [microsoft-docs-marketplace]="microsoft-docs"
    [fabric-collection]="fabric-skills"
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

# Add custom marketplaces (skip if already installed)
for marketplace_name in "${!MARKETPLACE_REPOS[@]}"; do
    repo="${MARKETPLACE_REPOS[$marketplace_name]}"
    if copilot plugin marketplace list 2>/dev/null | grep -qF "$marketplace_name"; then
        echo -e "${DIM}[marketplace]${NC} ${BRIGHT_CYAN}$marketplace_name${NC} ${DIM}already installed, skipping${NC}"
    else
        echo -e "${DIM}[marketplace]${NC} ${BRIGHT_CYAN}$marketplace_name${NC} ${DIM}($repo)${NC}"
        copilot plugin marketplace add "$repo"
    fi
done

# Install plugins grouped by marketplace (skip if marketplace not installed)
for marketplace_name in "${!PLUGINS[@]}"; do
    if ! copilot plugin marketplace list 2>/dev/null | grep -qF "$marketplace_name"; then
        echo -e "${DIM}[plugins]${NC} ${BRIGHT_CYAN}$marketplace_name${NC} ${DIM}marketplace not installed, skipping plugins${NC}"
        continue
    fi
    plugins="${PLUGINS[$marketplace_name]}"
    echo ""
    echo -e "${DIM}[plugins]${NC} ${BRIGHT_CYAN}$marketplace_name${NC}"
    for plugin in $plugins; do
        echo -e "  ${BRIGHT_WHITE}▶${NC} $plugin ${DIM}@ $marketplace_name${NC}"
        copilot plugin install "$plugin@$marketplace_name"
    done
done
