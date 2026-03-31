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
4. **Start using Copilot**: Once ready, the `copilot` and `yolo` commands are available in the terminal

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

## Customization

All configuration lives in `.devcontainer/scripts/setup-copilot.sh`. The orchestrator `.devcontainer/onCreateCommand.sh` calls setup scripts on container creation.

### Adding a New Marketplace

Edit the `MARKETPLACE_REPOS` array in `.devcontainer/scripts/setup-copilot.sh`:

```bash
declare -A MARKETPLACE_REPOS=(
    [my-marketplace]="owner/repo"
    [microsoft-docs-marketplace]="microsoftdocs/mcp"
)
```

### Adding Plugins

Edit the `PLUGINS` array in `.devcontainer/scripts/setup-copilot.sh`:

```bash
declare -A PLUGINS=(
    [my-marketplace]="plugin1 plugin2 plugin3"
    [microsoft-docs-marketplace]="microsoft-docs"
)
```

Plugins are listed by name, separated by spaces, under their corresponding marketplace.

### Adding Skills

Skills are reusable AI instruction sets installed via [skills.sh](https://skills.sh/). Edit the `SKILLS_TO_INSTALL` array in `.devcontainer/scripts/setup-copilot.sh`:

```bash
declare -A SKILLS_TO_INSTALL=(
    ["anthropics/skills"]="skill-creator"
    ["my-org/my-skills"]="skill-a skill-b"
)
```

- **Key**: the `owner/repo` hosting the skills
- **Value**: space-separated list of skill names to install from that repo

### Applying Changes

After editing `setup-copilot.sh`, rebuild the Dev Container:

1. Open the VS Code **Command Palette** (Ctrl+Shift+P / Cmd+Shift+P)
2. Run **Dev Containers: Rebuild Container**
3. Wait for the container to rebuild and install

## Learn More

- [GitHub Copilot CLI Documentation](https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-the-command-line)
- [GitHub Copilot CLI GitHub Repository](https://github.com/githubnext/copilot-cli)
- [skills.sh — Browse & discover AI skills](https://skills.sh/)
- [VS Code DevContainers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [Development Containers Specification](https://containers.dev/)
- [VS Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview)
