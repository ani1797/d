# ~/.config/fish/config.fish

# If not running interactively, don't do anything
status is-interactive; or return

# XDG Base Directory defaults
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config

# Ensure ~/.local/bin is in PATH
contains $HOME/.local/bin $PATH; or fish_add_path $HOME/.local/bin

# conf.d/*.fish scripts are auto-sourced by fish — no need to source them here.
# Place modular configs in $XDG_CONFIG_HOME/fish/conf.d/*.fish

# Source local overrides
if test -f $HOME/.config/fish/config.local.fish
    source $HOME/.config/fish/config.local.fish
end
