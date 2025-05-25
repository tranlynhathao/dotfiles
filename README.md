<div align="center">

# 🛠️ My Dotfiles

> Personal configuration files for a clean, consistent, and powerful development environment on macOS (or Linux).

</div>

## Informations

<img alt="screenshot" align="right" width="400px" src="img/fastfetch.png"/>

<!-- - OS: [macOS Sequoia](https://www.apple.com/vn/macos/macos-sequoia/) -->
<!-- - WM: [sway](https://swaywm.org/) -->
<!-- - Shell: [fish](https://fishshell.com/) -->
<!-- - Editor: [neovim](https://neovim.io/) -->
<!-- - Terminal: [kitty](https://sw.kovidgoyal.net/kitty/) -->
<!-- - Browser: [firefox](https://www.mozilla.org/en-US/firefox/) -->
<!-- - Launcher: [rofi](https://github.com/davatorium/rofi), [wayland fork](https://github.com/lbonn/rofi) -->
<!-- - Bar: [waybar](https://github.com/Alexays/Waybar) -->
<!-- - Colorscheme: [gruvbox](https://github.com/morhetz/gruvbox) -->
- OS: [macOS Sequoia](https://www.apple.com/macos/macos-sequoia/)
- Hardware: [Apple M1 Pro](https://www.apple.com/newsroom/2021/10/introducing-m1-pro-and-m1-max-the-most-powerful-chips-apple-has-ever-built/)
- Shell: [fish](https://fishshell.com/)
- Editor: [neovim](https://neovim.io/)
- Terminal: [kitty](https://sw.kovidgoyal.net/kitty/)
- Browser: [Safari](https://www.apple.com/lae/safari/), [Firefox](https://www.mozilla.org/en-US/firefox/)
- Launcher: [Raycast](https://www.raycast.com/)
- Colorscheme: [gruvbox](https://github.com/morhetz/gruvbox) (via kitty & neovim theme)

## 📁 Structure

```bash
dotfiles/
├── .config/                # XDG-compliant application configs
│   ├── tmux/
│   ├── kitty/
│   └── ...
├── nvchad-config/          # Neovim config (as a Git submodule), resources: mgastonportillo
├── .gitmodules             # Submodule tracking file
├── .zshrc / .bashrc        # Shell configs
├── .gitconfig              # Git personal settings
└── README.md               # This file
````

## 🔌 Submodules

This repository uses [Git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to manage large or external configs like Neovim.

- `nvchad-config/` is a submodule pointing to [nvchad-config](https://github.com/mgastonportillo/nvchad-config.git)

To clone the repo with submodules:

```bash
git clone --recurse-submodules https://github.com/tranlynhathao/dotfiles.git
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

- Nerd Fonts: `FiraCode Nerd Font`, `VictorMono Nerd Font`
- Terminal emulator: [Kitty](https://sw.kovidgoyal.net/kitty/)
- Shell: [Fish](https://fishshell.com/) or [Zsh](https://www.zsh.org/)
- Prompt: [Starship](https://starship.rs/)

## ⚙️  Tools & Technologies

- [Neovim](https://neovim.io/) (with [NvChad](https://nvchad.com/))
- [tmux](https://github.com/tmux/tmux)
- [Kitty terminal](https://sw.kovidgoyal.net/kitty/)
- [Fish shell](https://fishshell.com/) / [Zsh](https://www.zsh.org/)
- [Starship prompt](https://starship.rs/)

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
