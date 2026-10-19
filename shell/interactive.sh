# One-line prompt, aliases and editing behavior shared by bash and zsh.
alias ..='cd ..'
alias ...='cd ../..'
alias j='just'
alias ls='ls -G'
alias l='ls -all'
alias ll='ls -lh'
alias la='ls -lAh'
alias lsa='ls -lah'
alias md='mkdir -p'
alias rd='rmdir'
alias -- -='cd -'
alias _='sudo '
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}'
alias egrep='grep -E'
alias fgrep='grep -F'
alias v='nvim'
alias nv='nvim .'
alias t='tmux'
alias g='git'
alias ga='git add .'
alias gs='git status -sb --porcelain'
alias gc='git commit -svp'
alias gp='git push'
alias gl='git pull --rebase'
alias lg='git log --oneline --graph --decorate'
alias gk='gitk'
alias iap='echo 6974277320616c6c20706f737369626c652e'
alias dsa='nvim ~/programming/MASTER.txt'
alias dv='cd ~/programming/'
alias docs='cd ~/Documents/Sync/ && nvim .'
alias kb='cat ~/.config/shell/interactive.sh'
alias py='python3'
alias pipi='uv pip install'
alias gcc='g++-14 -Wall -Wextra -pedantic -std=c++2a'
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tls='tmux ls'
alias cr='codex --dangerously-bypass-hook-trust'

[ ! -s "$NVM_DIR/nvm.sh" ] || . "$NVM_DIR/nvm.sh"
[ ! -s "$NVM_DIR/bash_completion" ] || . "$NVM_DIR/bash_completion"

set -o vi
[ ! -t 0 ] || stty -ixon
HISTSIZE=50000

if [ -n "${ZSH_VERSION:-}" ]; then
    PS1='%n@%m:%B%F{10}%~%f%b$ '
    RPROMPT=''
    HISTFILE="$HOME/.zsh_history"
    SAVEHIST=50000
    setopt EXTENDED_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE
    # Restore completion and history navigation without loading a theme framework.
    setopt AUTO_MENU COMPLETE_IN_WORD ALWAYS_TO_END
    zmodload zsh/complist
    zstyle ':completion:*' menu select
    zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
    autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search
    for shell_keymap in viins vicmd; do
        bindkey -M "$shell_keymap" '^R' history-incremental-search-backward
        bindkey -M "$shell_keymap" '^[[A' up-line-or-beginning-search
        bindkey -M "$shell_keymap" '^[OA' up-line-or-beginning-search
        bindkey -M "$shell_keymap" '^[[B' down-line-or-beginning-search
        bindkey -M "$shell_keymap" '^[OB' down-line-or-beginning-search
        bindkey -M "$shell_keymap" '^I' expand-or-complete
        bindkey -M "$shell_keymap" '^[[Z' reverse-menu-complete
    done
    unset shell_keymap
else
    PS1='\u@\h:\[\e[1;92m\]\w\[\e[0m\]$ '
    HISTFILE="$HOME/.bash_history"
    HISTFILESIZE=50000
    HISTCONTROL=ignoreboth
    shopt -s histappend checkwinsize
    case ";${PROMPT_COMMAND:-};" in
        *';history -a; history -n;'*) ;;
        *) PROMPT_COMMAND="history -a; history -n${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
    esac
    bind 'set completion-ignore-case on'
    for shell_keymap in vi-insert vi-command; do
        bind -m "$shell_keymap" '"\C-r": reverse-search-history'
        bind -m "$shell_keymap" '"\e[A": history-search-backward'
        bind -m "$shell_keymap" '"\eOA": history-search-backward'
        bind -m "$shell_keymap" '"\e[B": history-search-forward'
        bind -m "$shell_keymap" '"\eOB": history-search-forward'
        bind -m "$shell_keymap" '"\C-i": complete'
        if [ "${BASH_VERSINFO[0]}" -ge 4 ]; then
            bind -m "$shell_keymap" '"\e[Z": menu-complete-backward'
        fi
    done
    unset shell_keymap
    # Use the Git completion already installed with the previous shell setup.
    [ ! -r "$HOME/.oh-my-zsh/plugins/gitfast/git-completion.bash" ] ||
        . "$HOME/.oh-my-zsh/plugins/gitfast/git-completion.bash"
fi

# Keep automatic tmux entry, while allowing detach and nested bash/zsh sessions.
# TERM_STYLE_NO_TMUX=1 skips entry for a one-off shell.
if [ -z "${TMUX:-}" ] && [ -z "${TERM_STYLE_TMUX_STARTED:-}" ] && \
    [ -z "${TERM_STYLE_NO_TMUX:-}" ] && [ -t 0 ] && [ -t 1 ] && \
    command -v tmux >/dev/null 2>&1; then
    export TERM_STYLE_TMUX_STARTED=1
    tmux new-session -A -s working
fi
