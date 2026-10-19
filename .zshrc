. "$HOME/.config/shell/env.sh"

# Native completion replaces the theme framework.
typeset -U fpath
fpath=("$HOME/.zsh/completions" /Applications/OrbStack.app/Contents/Resources/completions/zsh $fpath)
autoload -Uz compinit bashcompinit
compinit
bashcompinit
[ ! -r "$HOME/.bun/_bun" ] || . "$HOME/.bun/_bun"

. "$HOME/.config/shell/interactive.sh"
