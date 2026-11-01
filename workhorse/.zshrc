. "$HOME/.config/shell/env.sh"
typeset -U fpath
fpath=("$HOME/.zsh/completions" $fpath)
autoload -Uz compinit bashcompinit
compinit
bashcompinit
. "$HOME/.config/shell/interactive.sh"
