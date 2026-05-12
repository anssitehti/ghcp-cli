
#!/bin/bash
set -euo pipefail

# ============================================================================
# CONFIGURATION - Modify these to add/remove marketplaces, plugins, and skills
# ============================================================================

# Default model for the yolo alias (full permissions mode)
DEFAULT_COPILOT_MODEL="gpt-5.4-mini"

# Define custom marketplaces and their repository locations
# Format: [marketplace-name]="owner/repo"
# Note: awesome-copilot and copilot-plugins are included by default
declare -A MARKETPLACE_REPOS=(

)

# Define plugins organized by marketplace
# Format: [marketplace-name]="plugin1 plugin2 plugin3"
# Note: plugins for commented-out marketplaces are safely skipped
declare -A PLUGINS=(
    [awesome-copilot]="copilot-sdk"
)

# Define skills to install via npx skills
# Format: ["owner/repo"]="skill1 skill2 skill3"
declare -A SKILLS_TO_INSTALL=(
    ["anthropics/skills"]="skill-creator"
    ["upstash/context7"]="context7-cli"
    ["mattpocock/skills"]="write-a-prd grill-me"
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
YoloAlias="alias yolo=\"copilot --allow-all --model $DEFAULT_COPILOT_MODEL\""
if grep -qF 'alias yolo=' ~/.bashrc 2>/dev/null; then
    sed -i '/alias yolo=/d' ~/.bashrc
fi
echo "$YoloAlias" >> ~/.bashrc
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

# Install AI skills using npx skills add
for repo_url in "${!SKILLS_TO_INSTALL[@]}"; do
    skill_names="${SKILLS_TO_INSTALL[$repo_url]}"
    echo -e "${DIM}[skills]${NC} ${BRIGHT_CYAN}$repo_url${NC}"
    for skill in $skill_names; do
        echo -e "  ${BRIGHT_WHITE}▶${NC} $skill"
    done
    # shellcheck disable=SC2086
    npx --yes skills add "$repo_url" --skill $skill_names --global --yes --agent github-copilot
done
