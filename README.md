<div align="center">

# Dotfiles

**Personal configuration files for a clean, consistent, and powerful development environment on macOS**

---

</div>

## Table of Contents

- [Overview](#overview)
- [System Information](#system-information)
- [Repository Structure](#repository-structure)
- [Quick Start](#quick-start)
- [Installation Guide](#installation-guide)
- [Configuration Details](#configuration-details)
- [Tools & Technologies](#tools--technologies)
- [Customization](#customization)
- [Maintenance](#maintenance)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

---

## Overview

This repository contains a comprehensive collection of dotfiles and configuration files for various development tools and applications. The setup is designed to be:

- **Modular** - Each tool's configuration is self-contained
- **Maintainable** - Clear structure and documentation
- **Portable** - Works across different machines with minimal adjustments
- **Performant** - Optimized for speed and efficiency
- **Aesthetic** - Consistent color scheme and visual design

---

## System Information

| Component | Details |
|-----------|---------|
| **Operating System** | macOS Sequoia |
| **Hardware** | Apple M1 Pro |
| **Shell** | Zsh with Oh My Zsh |
| **Editor** | Neovim (with NvChad configuration) |
| **Terminal** | Kitty |
| **Browser** | Safari, Firefox |
| **Launcher** | Raycast |
| **Color Scheme** | Gruvbox (via Kitty & Neovim theme) |

---

## Repository Structure

```
dotfiles/
│
├── .config/                    # XDG-compliant application configs
│   ├── nvim/                  # Neovim configuration (submodule)
│   ├── tmux/                  # Tmux configuration and plugins
│   ├── kitty/                 # Kitty terminal configuration
│   └── ...                    # Other application configs
│
├── nvchad-config/             # NvChad Neovim config (submodule)
│
├── zsh/                       # Zsh configuration files
│   ├── zshrc/                # Modular zsh configuration
│   │   ├── aliases.zsh
│   │   ├── env.zsh
│   │   ├── plugins.zsh
│   │   └── ...
│   └── .zshrc                # Main zsh configuration
│
├── vim/                       # Vim configuration files
│   ├── vim_plugins.vim
│   └── vim_programming.vim
│
├── bash/                      # Bash configuration
│   └── .bashrc
│
├── flake.nix                  # Nix flake configuration
├── flake.lock                 # Nix flake lock file
├── Brewfile                   # Homebrew package list
├── setup.sh                   # Setup script using GNU Stow
├── fonts.sh                   # Font installation script
└── README.md                  # This file
```

---

## Quick Start

<details>
<summary><strong>Click to expand quick installation steps</strong></summary>

```bash
# 1. Clone the repository
git clone --recurse-submodules https://github.com/tranlynhathao/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Run setup script
./setup.sh

# 3. Install dependencies
brew bundle
./fonts.sh
```

</details>

---

## Installation Guide

### Prerequisites

Before setting up these dotfiles, ensure you have the following installed:

| Requirement | Installation Command |
|-------------|---------------------|
| **Git** | Usually pre-installed on macOS |
| **GNU Stow** | `brew install stow` |
| **Zsh** | Default shell on macOS |
| **Homebrew** | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` |

---

### Step 1: Clone the Repository

Clone this repository to your home directory with all submodules:

```bash
git clone --recurse-submodules https://github.com/tranlynhathao/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

**If you've already cloned without submodules:**

```bash
git submodule update --init --recursive
```

---

### Step 2: Run the Setup Script

The setup script uses GNU Stow to create symlinks for all configuration files:

```bash
./setup.sh
```

**Alternative manual method:**

```bash
stow .
```

This will create symlinks from your home directory to the configuration files in this repository.

---

### Step 3: Install Dependencies

#### Homebrew Packages

Install all packages defined in the Brewfile:

```bash
brew bundle
```

This will install all applications, command-line tools, and dependencies listed in the `Brewfile`.

#### Fonts

Install required fonts for terminal and editor:

```bash
./fonts.sh
```

**Required fonts:**
- FiraCode Nerd Font
- VictorMono Nerd Font

#### Shell Configuration

If using Zsh with Oh My Zsh, follow the instructions in `zsh/README.md` to set up plugins and themes.

---

## Configuration Details

### Git Submodules

This repository uses Git submodules to manage external configurations and plugins:

| Submodule | Purpose |
|-----------|---------|
| **Neovim Configuration** | NvChad-based configuration |
| **Tmux Plugins** | Various tmux plugins for enhanced functionality |
| **Base16 Shell** | Base16 color scheme support |

**Update all submodules:**

```bash
git submodule update --remote --merge
```

**Remove a submodule (if needed):**

```bash
git submodule deinit -f <submodule-name>
git rm -f <submodule-name>
rm -rf .git/modules/<submodule-name>
```

---

## Tools & Technologies

### Development Tools

| Tool | Description |
|------|-------------|
| **Neovim** | Modern Vim fork with Lua-based configuration |
| **Tmux** | Terminal multiplexer for managing multiple terminal sessions |
| **Kitty** | GPU-accelerated terminal emulator |
| **Git** | Version control system with custom configuration |

### Shell and Terminal

| Tool | Description |
|------|-------------|
| **Zsh** | Interactive shell with Oh My Zsh framework |
| **Starship** | Fast and customizable prompt for any shell |
| **FZF** | Command-line fuzzy finder |
| **Zoxide** | Smarter cd command |

### Package Management

| Tool | Description |
|------|-------------|
| **Homebrew** | macOS package manager |
| **Nix** | Declarative package and system management (via flake.nix) |

### Additional Tools

| Tool | Description |
|------|-------------|
| **Raycast** | Application launcher and productivity tool |
| **Various CLI tools** | See Brewfile for complete list |

---

## Customization

### Adding New Configurations

1. Create a new directory in the repository root
2. Add your configuration files to that directory
3. Run `stow <directory-name>` to create symlinks

**Example:**

```bash
mkdir myapp
# Add config files to myapp/
stow myapp
```

### Modifying Existing Configurations

Edit the configuration files directly in the repository. Changes will be reflected immediately since they are symlinked to your home directory.

### Updating Packages

To update the Brewfile with currently installed packages:

```bash
brew bundle dump --force
```

---

## Maintenance

### Updating Submodules

Regularly update submodules to get the latest changes:

```bash
git submodule update --remote --merge
```

### Syncing Changes

After making changes, commit and push:

```bash
git add .
git commit -m "Update configuration"
git push
```

### Backup Before Changes

Always backup your current configuration before making major changes:

```bash
# Create a backup directory
mkdir -p ~/dotfiles-backup

# Backup specific configs
cp ~/.zshrc ~/dotfiles-backup/
cp -r ~/.config/nvim ~/dotfiles-backup/
```

---

## Troubleshooting

### Common Issues

<details>
<summary><strong>Symlink Issues</strong></summary>

If symlinks are not created correctly, remove existing files and re-run stow:

```bash
# Remove conflicting files (be careful!)
rm ~/.zshrc  # Example
stow zsh
```

</details>

<details>
<summary><strong>Submodule Issues</strong></summary>

If submodules are not initialized:

```bash
git submodule update --init --recursive
```

</details>

<details>
<summary><strong>Permission Issues</strong></summary>

Ensure scripts are executable:

```bash
chmod +x setup.sh fonts.sh
```

</details>

<details>
<summary><strong>Homebrew Bundle Issues</strong></summary>

If `brew bundle` fails, try:

```bash
brew bundle install
```

Or install missing dependencies manually:

```bash
brew install <package-name>
```

</details>

---

## Contributing

While these are personal dotfiles, suggestions and improvements are welcome.

**Ways to contribute:**
- Open an issue for bugs or suggestions
- Submit a pull request for improvements
- Fork the repository for your own use

---

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- **NvChad community** for the excellent Neovim configuration framework
- **All developers** of the tools and plugins used in this setup
- **The dotfiles community** for inspiration and best practices

---

<div align="center">

**For questions or suggestions, please open an issue on GitHub.**

Made with attention to detail

</div>
