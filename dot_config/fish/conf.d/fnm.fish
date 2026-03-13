# fnm (Fast Node Manager) shell integration
if test -d "$HOME/.local/share/fnm"
    fish_add_path --path "$HOME/.local/share/fnm"
end
if type -q fnm
    fnm env --use-on-cd --shell fish | source
    fnm completions --shell fish | source
end
