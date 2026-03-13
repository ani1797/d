# Set Neovim as default editor
if command -v nvim &>/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
    alias vi="nvim"
    alias vim="nvim"
fi
