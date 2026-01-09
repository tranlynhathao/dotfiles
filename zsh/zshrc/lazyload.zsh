# Lazy loading cho fzf
function lazy_fzf() {
  source ~/.zshrc.fzf
  unalias lazy_fzf
}
alias lazy_fzf=lazy_fzf

# Lazy loading cho conda
function lazy_conda() {
  __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  eval "$__conda_setup"
}
alias lazy_conda=lazy_conda
