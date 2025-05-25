# 🛠️ My Dotfiles

> Personal configuration files for a clean, consistent, and powerful development environment on macOS (or Linux).

## 📁 Structure

```bash
dotfiles/
├── .config/                # XDG-compliant application configs
│   ├── tmux/
│   ├── kitty/
│   └── ...
├── nvchad-config/                   # Neovim config (as a Git submodule), resources: mgastonportillo
├── .gitmodules             # Submodule tracking file
├── .zshrc / .bashrc        # Shell configs
├── .gitconfig              # Git personal settings
└── README.md               # This file
````

## 🔌 Submodules

This repository uses [Git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to manage large or external configs like Neovim.

* `nvchad-config/` is a submodule pointing to [nvchad-config](https://github.com/mgastonportillo/nvchad-config.git)

To clone the repo with submodules:

```bash
git clone --recurse-submodules https://github.com/yourusername/dotfiles.git
```

If you’ve already cloned it:

```bash
git submodule update --init --recursive
```

## 🔗 How to Use

### 1. Create symlinks

You can link configs to the appropriate locations:

```bash
ln -s ~/dotfiles/.config ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim
```

> Alternatively, you can use a dotfile manager like [`stow`](https://www.gnu.org/software/stow/) or [`home-manager`](https://nix-community.github.io/home-manager/).

### 2. Install dependencies

* Nerd Fonts: `FiraCode Nerd Font`, `VictorMono Nerd Font`
* Terminal emulator: [Kitty](https://sw.kovidgoyal.net/kitty/)
* Shell: [Fish](https://fishshell.com/) or [Zsh](https://www.zsh.org/)
* Prompt: [Starship](https://starship.rs/)

## ⚙️ Tools & Technologies

* [Neovim](https://neovim.io/) (with [NvChad](https://nvchad.com/))
* [tmux](https://github.com/tmux/tmux)
* [Kitty terminal](https://sw.kovidgoyal.net/kitty/)
* [Fish shell](https://fishshell.com/) / [Zsh](https://www.zsh.org/)
* [Starship prompt](https://starship.rs/)

## 🧠 Philosophy

Each tool is modularized and easy to maintain. This setup aims to be fast, aesthetic, and minimal while remaining highly customizable.

## 🧼 Remove Submodule (if needed)

```bash
git submodule deinit -f nvim
git rm -f nvim
rm -rf .git/modules/nvim
```

## 📬 Feedback & Issues

Feel free to fork, raise an issue, or reach out if you want to suggest improvements.

## 📜 License

[MIT License](https://github.com/tranlynhathao/dotfiles?tab=MIT-1-ov-file)
<!-- [MIT License](./LICENSE) -->
