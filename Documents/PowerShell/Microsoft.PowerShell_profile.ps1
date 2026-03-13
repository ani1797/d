# PowerShell profile

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
