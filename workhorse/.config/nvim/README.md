# Terminal theme integration

- `lua/terminal_theme.lua` owns Neovim theme selection and focus/buffer callbacks.
- `init.lua` loads it with `require("terminal_theme").setup()`.
- `refresh-theme.sh` refreshes running editors over RPC. The remote `~/.local/bin/term-theme` delegates to this script after updating tmux.
- `colors/reference.lua` supplies the light/dark palettes. The selected mode is the target of `~/.config/terminal-style/current`.

Reusable copies and installation instructions are in `~/programming/macnotify/examples/ssh-theme/`. Macnotify's Rust core only handles macOS events and running a supplied command; it contains no Neovim, tmux, or SSH logic.
