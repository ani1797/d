# direnv shell integration
if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi
