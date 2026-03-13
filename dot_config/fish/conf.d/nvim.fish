# Set Neovim as default editor
if command -sq nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    alias vi nvim
    alias vim nvim
end
