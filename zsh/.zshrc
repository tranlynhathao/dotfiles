# Fast interactive shell config.
#
# This file is interactive-only. Keep login environment in ~/.zprofile and keep
# ~/.zshenv minimal so every zsh process doesn't pay for prompt/plugin startup.

# Powerlevel10k instant prompt must stay near the top.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
typeset -gU path PATH fpath FPATH

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"
export ZSH_DISABLE_COMPFIX=true

# Keep completion cache out of $HOME clutter and stable across sessions.
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump-${HOST%%.*}-${ZSH_VERSION}"

# Lean OMZ plugin set. Removed rbenv/bundler/ruby/macOS plugins to cut startup
# cost and avoid overlapping version-manager initialization.
plugins=(
  git
  web-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Avoid OMZ startup update checks in interactive shells.
zstyle ':omz:update' mode disabled

source "$ZSH/oh-my-zsh.sh"
[[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
[[ -r "$HOME/.openai.env" ]] && source "$HOME/.openai.env"

# History / editing ergonomics.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS

export GPG_TTY="$TTY"
export EDITOR="${EDITOR:-nvim}"
export BAT_THEME="${BAT_THEME:-gruvbox-dark}"

bindkey -v
bindkey '^L' clear-screen

vi-jj() { zle vi-cmd-mode; }
zle -N vi-jj
bindkey -M viins 'jj' vi-jj

# Prefer static FZF shell scripts over running `fzf --zsh` at startup.
if [[ -r /opt/homebrew/opt/fzf/shell/completion.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi
if [[ -r /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type=d --hidden --strip-cwd-prefix --exclude .git'
export FZF_DEFAULT_OPTS='--color=fg:#CBE0F0,bg:#011628,hl:#B388FF,fg+:#CBE0F0,bg+:#143652,hl+:#B388FF,info:#06BCE4,prompt:#2CF9ED,pointer:#2CF9ED,marker:#2CF9ED,spinner:#2CF9ED,header:#2CF9ED'
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

[[ -r "$HOME/fzf-git.sh/fzf-git.sh" ]] && source "$HOME/fzf-git.sh/fzf-git.sh"

# Keep cheap, high-value interactive tools eager.
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(direnv hook zsh)"

# Lazy NVM: biggest single startup win without losing node/npm ergonomics.
export NVM_DIR="$HOME/.nvm"

__load_nvm() {
  unset -f nvm node npm npx corepack
  [[ -s "$NVM_DIR/nvm.sh" ]] || return 127
  source "$NVM_DIR/nvm.sh" --no-use
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
}

for __cmd in nvm node npm npx corepack; do
  eval "${__cmd}() { __load_nvm || return; ${__cmd} \"\$@\"; }"
done
unset __cmd

# Lazy Conda/Mamba. Do not run python-backed shell hooks at prompt startup.
__load_conda_stack() {
  unset -f conda mamba micromamba
  if [[ -r /opt/anaconda3/etc/profile.d/conda.sh ]]; then
    source /opt/anaconda3/etc/profile.d/conda.sh
    return 0
  fi
  if [[ -r "$HOME/miniforge3/etc/profile.d/conda.sh" ]]; then
    source "$HOME/miniforge3/etc/profile.d/conda.sh"
    return 0
  fi
  return 127
}

conda() {
  __load_conda_stack || return 127
  conda "$@"
}

mamba() {
  __load_conda_stack || return 127
  command mamba "$@"
}

micromamba() {
  __load_conda_stack || return 127
  command micromamba "$@"
}

# Lazy SDKMAN keeps sdk available without paying startup cost on every shell.
sdk() {
  unset -f sdk
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] || return 127
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk "$@"
}

# Keep rbenv command available but avoid eager shell integration.
rbenv() {
  unset -f rbenv
  eval "$(command rbenv init - zsh)"
  rbenv "$@"
}

# iTerm-only integration. Don't make Kitty/Ghostty pay for it.
if [[ $TERM_PROGRAM == iTerm.app && -r "$HOME/.iterm2_shell_integration.zsh" ]]; then
  source "$HOME/.iterm2_shell_integration.zsh"
fi

mkcd() {
  mkdir -p -- "$1" && builtin cd -- "$1"
}

cdf() {
  local dir
  dir=$(fd --type d --hidden --exclude .git | fzf --height 40% --reverse --prompt='cd into> ') || return
  builtin cd -- "$dir"
}

y() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)" || return
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

cpp() {
  [[ $# -ge 1 ]] || { echo "Usage: cpp output_file source1.cpp [source2.cpp ...]"; return 1; }
  local output_file="$1"
  shift
  clang++ -std=c++17 "$@" -o "$output_file" && ./"$output_file"
}

c() {
  [[ $# -ge 1 ]] || { echo "Usage: c output_file source1.c [source2.c ...]"; return 1; }
  local output_file="$1"
  shift
  clang -std=c11 "$@" -o "$output_file" && ./"$output_file"
}

alias sz='source ~/.zshrc'
alias nz='nvim ~/.zshrc'
alias nv='nvim'
alias nnv='nvim ~/.local/share/nvim/'
alias nskhd='nvim ~/.config/skhd/'
alias l='eza --git --icons'
alias ll='eza --git --icons -l'
alias la='eza --git --icons -a'
alias lla='eza --git --icons -la --bytes'
alias lza='eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions'
alias lxa='eza --color=always --long --git'
alias tra='eza -a --tree'
alias lg='lazygit'
alias cd='z'
alias cls='clear'
alias t='touch'
alias cat='bat --paging=never'
alias v="fd --type f --hidden --exclude .git | fzf-tmux -m -p --reverse --preview='bat --color=always {}' --preview-window=right:70%:wrap | xargs nvim"
alias vf="fd --type f --hidden --exclude .git | fzf --reverse --preview='bat --color=always {}' --preview-window=right:70%:wrap | xargs nvim"
alias g='/opt/homebrew/bin/g++-14'
alias sagesafe='TERM=xterm sage'
alias pathlist='print -rl -- $path'
alias desktop-hide='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias desktop-show='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'
alias save_kitty='kitty --session ~/.config/kitty/last-session.conf'
alias vtget='aria2c -x 32 -s 32 -k 1M --file-allocation=none --max-tries=0 --retry-wait=1 --auto-file-renaming=false'
