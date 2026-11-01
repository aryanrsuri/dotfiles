case $- in *i*) ;; *) return ;; esac
. "$HOME/.config/shell/env.sh"
. "$HOME/.config/shell/interactive.sh"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/Users/aryansuri/.juliaup/bin:*)
        ;;

    *)
        export PATH=/Users/aryansuri/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac
# Tab completion for juliaup and julia channel selection
[ -f "/Users/aryansuri/.julia/juliaup/completions/bash.sh" ] && source "/Users/aryansuri/.julia/juliaup/completions/bash.sh"

# <<< juliaup initialize <<<
