# PowerShell profile

# Neovim as default editor
if (Get-Command nvim -ErrorAction SilentlyContinue) {
    $env:EDITOR = "nvim"
    $env:VISUAL = "nvim"
    Set-Alias -Name vi -Value nvim
    Set-Alias -Name vim -Value nvim
}

# fnm (Fast Node Manager)
if (Get-Command fnm -ErrorAction SilentlyContinue) {
    fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
    fnm completions --shell powershell | Out-String | Invoke-Expression
}

# Starship prompt
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}

# Source local overrides
$localProfile = Join-Path $HOME ".PowerShell_profile.local.ps1"
if (Test-Path $localProfile) {
    . $localProfile
}
