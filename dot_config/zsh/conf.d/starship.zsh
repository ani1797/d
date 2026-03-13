# Starship prompt
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
    eval "$(starship completions zsh)"
fi
