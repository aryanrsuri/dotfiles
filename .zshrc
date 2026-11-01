. "$HOME/.config/shell/env.sh"

# Native completion replaces the theme framework.
typeset -U fpath
fpath=("$HOME/.zsh/completions" /Applications/OrbStack.app/Contents/Resources/completions/zsh $fpath)
autoload -Uz compinit bashcompinit
compinit
bashcompinit
[ ! -r "$HOME/.bun/_bun" ] || . "$HOME/.bun/_bun"

. "$HOME/.config/shell/interactive.sh"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/aryansuri/.juliaup/bin' $path)
export PATH
# Tab completion for juliaup and julia channel selection
[ -f "/Users/aryansuri/.julia/juliaup/completions/zsh.zsh" ] && source "/Users/aryansuri/.julia/juliaup/completions/zsh.zsh"

# <<< juliaup initialize <<<
