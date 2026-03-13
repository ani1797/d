# fnm (Fast Node Manager) shell integration
if [[ -d "$HOME/.local/share/fnm" ]]; then
    export PATH="$HOME/.local/share/fnm:$PATH"
fi
if command -v fnm &>/dev/null; then
    eval "$(fnm env --use-on-cd --shell bash)"
    eval "$(fnm completions --shell bash)"
fi
