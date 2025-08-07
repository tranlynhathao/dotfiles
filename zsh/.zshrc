# zmodload zsh/zprof
# Enable Pstruct Student *studentowerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# ---- config zshrc faster ----
alias sz="source ~/.zshrc"
alias nz="nvim ~/.zshrc"
# alias reload_all='tmux list-sessions -F "#S" | xargs -I {} tmux send-keys -t {} "source ~/.zshrc" Enter'
# ---- END ----

# ---- config nvim at local faster ----
alias nnv="nvim /Users/tranlynhathao/.local/share/nvim/"
# ---- END ----

# ---- config skhdrc faster ----
alias nskhd="nvim ~/.config/skhd/"
# ---- END ----

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"

# ---- homebrew ----
# export PATH="/usr/local/bin:$PATH" # if chip intel
export PATH="/opt/homebrew/bin:$PATH"
# ---- END ----

# ---- Path to your oh-my-zsh installation ----
export ZSH="$HOME/.oh-my-zsh"
# ---- END ----

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  web-search
  zsh-autosuggestions
  zsh-syntax-highlighting
  # zsh-async
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run alias.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run p10k configure or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# ---- OpenAI ----
[ -f ~/.openai.env ] && source ~/.openai.env
# ---- END ----

# ---- FZF ----
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
# ---- END ----

# ---- setup fzf theme ----
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"
# ---- END ----

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# ---- Use fd instead of fzf ----
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# ------  fzf-git ------
# CTRL-GCTRL-F for Files
# CTRL-GCTRL-B for Branches
# CTRL-GCTRL-T for Tags
# CTRL-GCTRL-R for Remotes
# CTRL-GCTRL-H for commit Hashes
# CTRL-GCTRL-L for reflogs
# CTRL-GCTRL-S for Stashes
# CTRL-GCTRL-W for Worktrees
# CTRL-GCTRL-E for Each ref (git for-each-ref)

source ~/fzf-git.sh/fzf-git.sh

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

source <(fzf --zsh)
# ---- END ----

# ----- Bat (better cat) -----
export BAT_THEME=gruvbox-dark
# ---- END ----

# ---- Eza (better ls) -----
alias lza="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lxa="eza --color=always --long --git"
# alias tr="eza --tree"
alias tra="eza -a --tree"
# ---- END -----

# ---- TheFuck -----
eval $(thefuck --alias)
eval $(thefuck --alias fk)
# ---- END -----

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
# zoxide init zsh | source
# ---- END ----

cdf() {
  local dir
  dir=$(fd --type d --hidden --exclude .git | fzf --height 40% --reverse --prompt="📁 cd into: ") &&
  cd "$dir"
}

# ---- ALIAS -----
alias l="eza --git --icons"
alias nv="nvim"
alias cat='bat --theme="Solarized (dark)"'
alias v="fd --type f --hidden --exclude .git | fzf-tmux -m -p --reverse --preview='bat --color=always {}' --preview-window=right:70%:wrap | xargs nvim"
alias vf="fd --type f --hidden --exclude .git | fzf --reverse --preview='bat --color=always {}' --preview-window=right:70%:wrap | xargs nvim"
alias pwd="pwd | lolcat"
alias sagesafe='TERM=xterm sage -python'

# v() {
#     async -q "fd --type f --hidden --exclude .git | fzf-tmux -m -p --reverse --preview='bat --color=always {}' --preview-window=right:70%:wrap | xargs nvim"
# }

alias pathlist='echo "$PATH" | tr ":" "\n"'
alias pathuniq='echo "$PATH" | tr ":" "\n" | awk "!seen[\$0]++"'
alias mplist="multipass list | grep -v Deleted"
alias cls="clear"
alias t="touch"
alias cd="z"
alias g='/opt/homebrew/bin/g++-14'
alias lg="lazygit"
# alias ll='ls -alF --color=auto'
# alias ls "eza --git --icons"
alias ll="eza --git --icons -l"
alias la="eza --git --icons -a"
alias lla="eza --git --icons -la --bytes"

alias desktop-hide="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias desktop-show="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
# ---- END ----

# ---- THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK ----
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# ---- CPP ----
# use g++-14
# cpp() {
#     if [ "$#" -lt 1 ]; then
#         echo "Usage: cpp output_file source_file1.cpp source_file2.cpp ..."
#         return 1
#     fi
#     output_file="$1"
#     shift
#     g "$@" -o "$output_file" && ./"$output_file"
# }
#
# c() {
#     if [ "$#" -lt 1 ]; then
#         echo "Usage: c output_file source_file1.c source_file2.c ..."
#         return 1
#     fi
#     output_file="$1"
#     shift
#     gcc-14 "$@" -o "$output_file" && ./"$output_file"
# }

# use clang++
cpp() {
    if [ "$#" -lt 1 ]; then
        echo "Usage: cpp output_file source_file1.cpp source_file2.cpp ..."
        return 1
    fi
    output_file="$1"
    shift
    clang++ -std=c++17 "$@" -o "$output_file" && ./"$output_file"
}

c() {
    if [ "$#" -lt 1 ]; then
        echo "Usage: c output_file source_file1.c source_file2.c ..."
        return 1
    fi
    output_file="$1"
    shift
    clang -std=c11 "$@" -o "$output_file" && ./"$output_file"
}

mkcd() {
    mkdir -p "$1" && cd "$1"
}

# cpp() {
#     if [ "$#" -lt 1 ]; then
#         echo "Usage: runcpp output_file source_file1.cpp source_file2.cpp ..."
#         return 1
#     fi
#     output_file="$1"
#     shift
#     async -q "g \"$@\" -o \"$output_file\" && ./$output_file"
# }

# ---- END ----

# >>> CONDA INITIALIZE >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< END <<<

LS_COLORS='di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32:bd=1;33;40:cd=1;33;40:su=0;41:sg=0;46:tw=1;42:ow=1;34;42:'
export LS_COLORS

# ---- YAZI ----
export EDITOR="nvim"
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
# ---- END ----

# ---- RUBY ----
# source /opt/homebrew/opt/chruby/share/chruby/auto.sh
# chruby ruby-3.1.3
# source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
# source /opt/homebrew/opt/chruby/share/chruby/auto.sh
# chruby ruby-3.1.3

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"
# ---- END ----

# ---- RVM ----
export PATH="$PATH:$HOME/.rvm/bin"
# ---- END ----

# ---- atuin (history of shell) -----
eval "$(atuin init zsh)"
# ---- END -----

# alias python="python3"
alias code="'/Applications/Visual Studio Code .app/Contents/Resources/app/bin/code'"

# ---- fetch OS -----
# neofetch
# pfetch
# macchina
# onefetch
# fastfetch
# ---- END -----

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ---- NPM ----
export PATH="$HOME/.npm-global/bin:$PATH"
# ---- END ----

# ---- PNPM ----
export PNPM_HOME="/Users/tranlynhathao/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# ---- END ----

[ -f "$(brew --prefix autojump)/etc/autojump.zsh" ] && . "$(brew --prefix autojump)/etc/autojump.zsh"

# ---- JAVA ----
# export JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
# ---- END ----

# ---- Iterm2 Shell Integration ----
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# ---- END ----

# ---- SONAR ----
export PATH="$PATH:/Users/tranlynhathao/sonar-scanner-6.2.1.4610-macosx-aarch64/bin"
eval "$(rbenv init -)"
# ---- END ----

# ---- Android ----
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
# ---- END ----

# ---- Go ----
export PATH=$PATH:$(go env GOPATH)/bin
# ---- END ----

# ---- LLVM ----
export PATH="/opt/homebrew/Cellar/llvm@18/18.1.8/bin:$PATH"
# export PATH="/opt/homebrew/Cellar/rust/1.81.0_1/lib/rustlib/aarch64-apple-darwin/bin/gcc-ld:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export PATH="/usr/local/opt/llvm/bin:$PATH"
# ---- END ----

# ---- basher ----
export PATH="$HOME/.basher/bin:$PATH"
# ---- END ----

# ---- gnu-sed ----
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
# ---- END ----

# ---- opencv ----
export DYLD_LIBRARY_PATH=/opt/homebrew/opt/opencv/lib:$DYLD_LIBRARY_PATH
# ---- END ----

# ---- ruby config ----
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# ---- END ----

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# ---- wezterm config ----
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
export PATH
# ---- END ----

export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export NODE_OPTIONS=--max-old-space-size=4096

# ---- ghcup config ----
[ -f "/Users/tranlynhathao/.ghcup/env" ] && . "/Users/tranlynhathao/.ghcup/env" # ghcup-env
export PATH="$HOME/.ghcup/bin:$PATH"
# ---- END ----

# ---- opam config ----
export PATH="$HOME/.opam/default/bin:$PATH"
# ---- END ----

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/tranlynhathao/.opam/opam-init/init.zsh' ]] || source '/Users/tranlynhathao/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

# Added by Windsurf
export PATH="/Users/tranlynhathao/.codeium/windsurf/bin:$PATH"

export PATH=$PATH:/opt/homebrew/Cellar/riscv-gnu-toolchain/main/bin

export PATH="/opt/homebrew/opt/docker-credential-helper/bin:$PATH"

export GPG_TTY=/dev/ttys002

# source $ZSH_CUSTOM/plugins/zgen/zgen.zsh

# zprof

# source ~/.zplug/init.zsh

# # Load ZI (new Zinit)
# zi light-mode for \
#   zsh-users/zsh-autosuggestions \
#   zsh-users/zsh-syntax-highlighting

# zi light zsh-users/zsh-autosuggestions
# zi light zsh-users/zsh-syntax-highlighting
# zi light Aloxaf/fzf-tab
# zi light jeffreytse/zsh-vi-mode
# zi light agkozak/zsh-z

# Example plugins
# zi light zsh-users/zsh-autosuggestions
# zi light zsh-users/zsh-syntax-highlighting
# zi light zdharma-continuum/fast-syntax-highlighting
# zi light z-shell/F-Sy-H

# source ~/.zi/bin/zi.zsh

# autoload -Uz compinit && compinit

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH="$HOME/.mix/escripts:$PATH"

function set_tab_title() {
  echo -ne "\033]2;${PWD##*/}\007"
}
PROMPT_COMMAND="set_tab_title${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# Created by `pipx` on 2025-06-04 13:45:23
export PATH="$PATH:/Users/tranlynhathao/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

# # pnpm
# export PNPM_HOME="/Users/tranlynhathao/Library/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# # pnpm end

# Enable vi mode like vim
bindkey -v

# Custom keybinding
bindkey '^L' clear-screen
function vi-jj() {
  zle vi-cmd-mode
}
zle -N vi-jj
bindkey -M viins 'jj' vi-jj

export CGO_CFLAGS="-I/opt/homebrew/include"
export CGO_LDFLAGS="-L/opt/homebrew/lib"

# Load Angular CLI autocompletion.
source <(ng completion script)

eval "$(direnv hook zsh)"

export XDG_CONFIG_HOME="$HOME/.config"

# >>> Nix integration >>>
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
# <<< Nix integration <<<

# pgrep skhd >/dev/null || /opt/homebrew/bin/skhd &
