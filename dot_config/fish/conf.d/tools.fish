# Modern CLI tool aliases and environment for fish
# Tools: eza (ls), bat (cat), zoxide (cd), ripgrep, fd

# -- ripgrep config path --
set -gx RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/config"

# -- eza (modern ls replacement) --
if type -q eza
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -l --icons --group-directories-first --git --time-style=relative'
    alias la='eza -la --icons --group-directories-first --git --time-style=relative'
    alias lt='eza --tree --icons --level=2 --group-directories-first'
    alias lta='eza --tree --icons --level=2 --group-directories-first -a'
end

# -- bat (modern cat replacement) --
if type -q bat
    alias cat='bat --paging=never'
    alias catp='bat --plain --paging=never'
    # Use bat for man pages
    set -gx MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -l man -p'"
    set -gx MANROFFOPT "-c"
end

# -- zoxide (smarter cd) --
if type -q zoxide
    zoxide init fish | source
end
