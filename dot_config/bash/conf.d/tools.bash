# Modern CLI tool aliases and environment for bash
# Tools: eza (ls), bat (cat), zoxide (cd), ripgrep, fd

# -- ripgrep config path --
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/ripgrep/config"

# -- eza (modern ls replacement) --
if command -v eza &>/dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -l --icons --group-directories-first --git --time-style=relative'
    alias la='eza -la --icons --group-directories-first --git --time-style=relative'
    alias lt='eza --tree --icons --level=2 --group-directories-first'
    alias lta='eza --tree --icons --level=2 --group-directories-first -a'
fi

# -- bat (modern cat replacement) --
if command -v bat &>/dev/null; then
    alias cat='bat --paging=never'
    alias catp='bat --plain --paging=never'
    # Use bat for man pages
    export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -l man -p'"
    export MANROFFOPT="-c"
fi

# -- zoxide (smarter cd) --
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi
