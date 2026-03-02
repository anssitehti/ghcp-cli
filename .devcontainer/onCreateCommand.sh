#!/bin/bash
set -e

# Add yolo alias for Copilot AI (full permissions mode)
echo 'alias yolo="copilot --allow-all --model claude-haiku-4.5"' >> ~/.bashrc

# Install plugins
copilot plugin marketplace add anthropics/claude-plugins-official

PLUGINS=(
    "feature-dev"
    "code-review"
    "code-simplifier"
    "frontend-design"
    "context7"
    "skill-creator"
)

for plugin in "${PLUGINS[@]}"; do
    echo "Installing plugin: $plugin"
    copilot plugin install "$plugin@claude-plugins-official"
done
