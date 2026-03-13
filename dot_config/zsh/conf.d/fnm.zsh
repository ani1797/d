# fnm (Fast Node Manager) shell integration
if [[ -d "$HOME/.local/share/fnm" ]]; then
    export PATH="$HOME/.local/share/fnm:$PATH"
fi
if (( $+commands[fnm] )); then
    eval "$(fnm env --use-on-cd --shell zsh)"
    eval "$(fnm completions --shell zsh)"
fi
