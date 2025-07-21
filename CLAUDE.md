# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing CLI configurations and setup scripts for development environments across multiple platforms (macOS, Linux, Alpine, Ubuntu).

## Key Commands

### Setup and Installation
- `./scripts/settings.sh` - Complete environment setup (installs packages, tools, and creates symlinks)
- `./scripts/make_symlinks.sh` - Create symbolic links for all dotfiles to home directory
- `./scripts/build-image.sh` - Build Docker images for testing dotfiles in Ubuntu and Alpine containers

### Docker Testing Environment
- `./scripts/run-container.sh` - Run containerized environment with dotfiles
- `./scripts/push-image.sh` - Push built images to registry

## Configuration Architecture

### Core Configuration Files
- `.zshrc` - Oh My Zsh configuration with plugins (syntax highlighting, autosuggestions, fzf-tab)
- `.tmux.conf` - Tmux configuration with TPM plugins (catppuccin theme, resurrect, continuum)
- `.gitconfig` - Git configuration with useful aliases and SSH URL rewriting
- `.config/nvim/init.lua` - Neovim configuration using Lazy.nvim package manager
- `.golangci.yml` - Go linting configuration

### Neovim Configuration Structure
- Uses Lazy.nvim as the package manager
- Plugin configurations are modularized in `.config/nvim/lua/plugins/`
- LSP configurations in `.config/nvim/lua/plugins/lsp/`
- Leader key is set to comma (`,`)

### Shell Environment
- Uses Oh My Zsh with agnoster theme
- Includes fzf integration for fuzzy finding
- Automatic tmux window naming based on current directory

### Tool Integration
The setup script installs and configures:
- Development tools: git, vim, neovim, tmux, ripgrep
- Language runtimes: Node.js (via nvm), Python (via pyenv), Go (commented out)
- Shell enhancements: Oh My Zsh, fzf, zsh plugins

### Symlink Management
The `make_symlinks.sh` script creates symbolic links for:
- `.tmux.conf`, `.zshrc`, `.gitconfig`
- `.config/gh/config.yaml` (GitHub CLI)
- `.config/nvim` (Neovim configuration directory)
- `.golangci.yml`

All existing files are backed up with `.old` extension before creating symlinks.

## Docker Environment Testing
Two Dockerfiles provide testing environments:
- `Dockerfile-ubuntu` - Ubuntu-based testing environment
- `Dockerfile-alpine` - Alpine Linux-based testing environment

Images are versioned using the `version` file and tagged with both `latest` and version-specific tags.