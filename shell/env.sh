# Shared by login and interactive shells; safe to source again when switching shells.
if [ -x /opt/homebrew/bin/brew ] && [ -z "${HOMEBREW_PREFIX:-}" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export EDITOR=nvim VISUAL=nvim
export GOPATH="$HOME/go" NB="$HOME/programming/nb/bin"
export NVM_DIR="$HOME/.nvm" BUN_INSTALL="$HOME/.bun"

shell_prepend_path() {
    case ":$PATH:" in *:"$1":*) ;; *) PATH="$1:$PATH" ;; esac
}

for shell_bin in /opt/homebrew/sbin /opt/homebrew/bin /opt/homebrew/opt/python/libexec/bin \
    "$HOME/.cargo/bin" "$HOME/bin" "$HOME/.local/bin" "$HOME/.deno/bin" \
    "$GOPATH/bin" "$BUN_INSTALL/bin" "$NB"; do
    shell_prepend_path "$shell_bin"
done
for shell_bin in "$HOME/.orbstack/bin" "$HOME/Library/Application Support/Coursier/bin"; do
    case ":$PATH:" in *:"$shell_bin":*) ;; *) PATH="$PATH:$shell_bin" ;; esac
done
export PATH
unset shell_bin
unset -f shell_prepend_path
