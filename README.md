# macOS dotfiles

Active configuration captured from my Apple Silicon Mac on 2026-10-18.
The app configurations are copied unchanged. The Git template keeps identity
and signing-key fields blank, as in the original repository.

## Files

| Repository path | Location on this Mac |
| --- | --- |
| `.bash_profile`, `.bashrc`, `.profile` | Same names under `$HOME` |
| `.zprofile`, `.zshenv`, `.zshrc` | Same names under `$HOME` |
| `shell/` | `~/.config/shell/` |
| `.tmux.conf` | `~/.tmux.conf` |
| `nvim/` | `~/.config/nvim/` |
| `ghostty/config` | `~/Library/Application Support/com.mitchellh.ghostty/config` |
| `terminal-style/Reference.terminal` | `~/.config/terminal-style/Reference.terminal` |
| `.gitconfig` | Git settings template; fill in identity before using |

Shell history, logs, caches, generated completions, installed plugins, runtimes,
credentials, and private keys are intentionally excluded. Neovim's installed
plugins are represented by `nvim/lazy-lock.json`.

## Dependencies

This snapshot uses Neovim 0.11.6, tmux next-3.6, Ghostty 1.3.1, and the
ComicShanns Nerd Font. The captured nvim-lspconfig requires Neovim 0.11.3+;
the configuration uses `vim.lsp.config`.
The shell configuration uses Apple Silicon Homebrew paths under `/opt/homebrew`.

Neovim unconditionally loads my [nb](https://github.com/aryanrsuri/nb) plugin
from `~/programming/nb`. Clone that repository to this exact path before starting
Neovim. Build its CLI into the directory already on the shell's `PATH`:

```sh
mkdir -p "$HOME/programming"
git clone https://github.com/aryanrsuri/nb.git "$HOME/programming/nb"
mkdir -p "$HOME/programming/nb/bin"
cd "$HOME/programming/nb"
go build -o bin/nb .
```

Use the Go version required by nb's `go.mod`. The nb checkout at capture time
was `9183854754fac4f60e923f671a31802292889064`.
Neovim bootstraps lazy.nvim on first launch; use `:Lazy restore` to restore the
locked plugin revisions. Mason configures clangd, pyright, gopls, and
rust-analyzer. Install `ruff` separately for Python formatting and `ripgrep`
for Telescope live grep.

`.zshenv` sources `~/.cargo/env` unconditionally, so install Rust with rustup
before using it. Optional integrations load nvm and Bun when present. Bash Git
completion currently loads from `~/.oh-my-zsh/plugins/gitfast/git-completion.bash`
when that existing checkout is available; the shell does not load the Oh My Zsh
theme framework. Deno's generated completion is not versioned; recreate it if
using Deno:

```sh
mkdir -p "$HOME/.zsh/completions"
deno completions zsh > "$HOME/.zsh/completions/_deno.zsh"
```

The PATH also includes optional OrbStack and Coursier locations. Personal
shortcuts reference `~/programming/MASTER.txt` and `~/Documents/Sync`; those
documents are not included.

## Restore

Complete the dependencies above first. These commands replace configuration
files; back up any existing setup before running them. From this repository:

```sh
mkdir -p "$HOME/.config/shell" "$HOME/.config/nvim/colors" \
  "$HOME/.config/terminal-style" \
  "$HOME/Library/Application Support/com.mitchellh.ghostty"
cp .bash_profile .bashrc .profile .zprofile .zshenv .zshrc .tmux.conf "$HOME/"
cp shell/env.sh shell/interactive.sh "$HOME/.config/shell/"
cp nvim/init.lua nvim/lazy-lock.json "$HOME/.config/nvim/"
cp nvim/colors/reference.lua "$HOME/.config/nvim/colors/"
cp ghostty/config "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
cp terminal-style/Reference.terminal "$HOME/.config/terminal-style/"
```

For Terminal.app, open `terminal-style/Reference.terminal` to import the matching
profile. Ghostty uses its config directly. Reload Ghostty's configuration and
start a new shell after restoring.

Set `user.name`, `user.email`, and `user.signingkey` in a personal copy of
`.gitconfig` before installing it; commit and tag signing are enabled.

## Behavior

Both Bash and Zsh use the shared one-line prompt, vi editing, aliases, and
history settings. Interactive terminals automatically attach to the tmux
session `working`. To open a shell without attaching:

```sh
TERM_STYLE_NO_TMUX=1 zsh
```

tmux uses Ctrl-Space as its prefix; prefix + `r` reloads `.tmux.conf`.
Neovim uses Space as its leader: `ff` finds files, `fg` searches text, and `e`
toggles Neo-tree. The reference colorscheme shares its ANSI palette with
Ghostty and the Terminal profile.
