. "$HOME/.config/shell/env.sh"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/Users/aryansuri/.juliaup/bin:*)
        ;;

    *)
        export PATH=/Users/aryansuri/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
