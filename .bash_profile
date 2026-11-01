. "$HOME/.profile"
case $- in *i*) . "$HOME/.bashrc" ;; esac

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
