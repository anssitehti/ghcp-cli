# GitHub Copilot CLI: Secure Development Environment

A demonstration repository showcasing how to use **GitHub Copilot** in **VS Code** with a **DevContainer** environment to run coding agents in a safe and secure sandbox.

## Overview

This repository provides a production-ready [Dev Container](https://containers.dev/) setup that demonstrates best practices for:

- Running **GitHub Copilot CLI** agents safely and securely
- Isolating development workloads in a sandboxed container environment
- Leveraging VS Code with Copilot for AI-assisted coding tasks
- Executing automated coding operations with permission controls

The entire development environment is containerized, ensuring that any Copilot agent operations run in an isolated sandbox without affecting your host machine.

## Prerequisites

- [Docker](https://www.docker.com/) (for running containers)
- [VS Code](https://code.visualstudio.com/) with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) ([VS Code DevContainers Guide](https://code.visualstudio.com/docs/devcontainers/containers))

## Getting Started

1. **Clone or open this repository** in VS Code
2. **Open in Dev Container**: VS Code will detect the `.devcontainer` configuration and prompt you to "Reopen in Container"
3. **Wait for initialization**: The container will build and install the GitHub Copilot CLI automatically
4. **Start using Copilot**: Once ready, the `copilot` command is available in the terminal

## Key Features

- **Sandboxed Execution**: All Copilot operations run inside a containerized environment
- **Pre-configured**: GitHub Copilot CLI comes pre-installed and ready to use
- **Permission Controls**: Use `--allow-all` flag for full permissions or default restricted mode
- **Reproducible Environment**: Same setup works across Windows, macOS, and Linux

## Copilot CLI Commands

| Command | Description |
|---------|-------------|
| `copilot` | Run the GitHub Copilot CLI (default restricted mode) |
| `yolo` | Alias for `copilot --allow-all` (full permissions mode - use cautiously) |
| `copilot --help` | View all available Copilot commands |

## Dev Container Configuration

- **Base Image**: `mcr.microsoft.com/devcontainers/base:noble` (Ubuntu 24.04 LTS)
- **Copilot CLI**: Latest prerelease version from `ghcr.io/devcontainers/features/copilot-cli:1`
- **Isolation**: Complete filesystem and process isolation from the host

## Security & Safety

- ✅ Changes made by Copilot are contained within the container
- ✅ Host machine remains unaffected by container operations
- ✅ Easy to reset: Simply rebuild the container to start fresh
- ✅ Permission scoping: Control Copilot's access level with command flags

## Example Workflow

```bash
# Inside the container terminal:

# Run Copilot in default restricted mode
copilot explain "your question here"

# Or use full permissions when needed
yolo "create a new function for..."

# View available skills and features
copilot --help
```

## Adding Plugins and Marketplaces

The Copilot CLI environment comes pre-configured with popular plugins and marketplace integrations. You can customize this by editing the `.devcontainer/onCreateCommand.sh` file.

### Adding a New Marketplace

1. **Edit `.devcontainer/onCreateCommand.sh`**:
   ```bash
   declare -A MARKETPLACE_REPOS=(
       [my-marketplace]="owner/repo"  # Add your marketplace here
       [claude-plugins-official]="anthropics/claude-plugins-official"
       [microsoft-docs-marketplace]="microsoftdocs/mcp"
   )
   ```

2. **Specify marketplace repository** in the format `owner/repo` where the marketplace is hosted on GitHub.

### Adding Plugins to a Marketplace

1. **Edit the `PLUGINS` array** in `.devcontainer/onCreateCommand.sh`:
   ```bash
   declare -A PLUGINS=(
       [my-marketplace]="plugin1 plugin2 plugin3"
       [claude-plugins-official]="context7 feature-dev code-review code-simplifier frontend-design skill-creator"
       [microsoft-docs-marketplace]="microsoft-docs"
   )
   ```

2. **Install plugins** by:
   - Listing them by name, separated by spaces
   - Organizing them under their corresponding marketplace name
   - When the container starts, plugins are automatically installed

### Applying Changes

After editing `onCreateCommand.sh`, rebuild the Dev Container:

1. Open the VS Code **Command Palette** (Ctrl+Shift+P / Cmd+Shift+P)
2. Run **Dev Containers: Rebuild Container**
3. Wait for the container to rebuild and plugins to install

### Manual Plugin Management (Advanced)

You can also manage plugins directly in the terminal:

```bash
# Add a marketplace
copilot plugin marketplace add owner/repo

# Install a plugin from a marketplace
copilot plugin install plugin-name@marketplace-name

# List installed plugins
copilot plugin list

# Remove a plugin
copilot plugin remove plugin-name
```

## Learn More

- [GitHub Copilot CLI Documentation](https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-the-command-line)
- [GitHub Copilot CLI GitHub Repository](https://github.com/githubnext/copilot-cli)
- [VS Code DevContainers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [Development Containers Specification](https://containers.dev/)
- [VS Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview)
