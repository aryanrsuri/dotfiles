# Shared environment for Debian login and interactive shells.
export EDITOR=nvim VISUAL=nvim
export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/bin"
export NVM_DIR="$HOME/.nvm" BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/.local/share/pnpm"
shell_prepend_path() {
    case ":$PATH:" in *:"$1":*) ;; *) PATH="$1:$PATH" ;; esac
}
for shell_bin in "$HOME/.cargo/bin" "$HOME/bin" "$HOME/.deno/bin" \
    "$BUN_INSTALL/bin" "$PNPM_HOME/bin" "$PNPM_HOME" "$HOME/.local/bin"; do
    shell_prepend_path "$shell_bin"
done
export PATH
unset shell_bin
unset -f shell_prepend_path
export UV_TOOL_DIR="$HOME/.local/opt/uv-tools"
