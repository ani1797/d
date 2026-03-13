# install.ps1 - Non-interactive dotfiles bootstrap for Windows PowerShell
#
# Primary target: GitHub Codespaces (auto-detects git config).
# Also works standalone with explicit environment variables.
#
# Only installs chezmoi and applies dotfiles.
# Tool-specific installs (starship, direnv, gh copilot) are handled by
# chezmoi run_once_ scripts after apply.
#
# Usage:
#   .\install.ps1                                              # auto-detect
#   $env:GIT_AUTHOR_NAME = "X"; $env:GIT_AUTHOR_EMAIL = "x@y"
#   .\install.ps1                                              # override
#
# Environment variables (checked in order):
#   GIT_AUTHOR_NAME   / GIT_COMMITTER_NAME  / git config user.name   → name
#   GIT_AUTHOR_EMAIL  / GIT_COMMITTER_EMAIL / git config user.email  → email
#   DOTFILES_REPO     - Chezmoi source repo (default: current directory)
#
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ── Resolve name and email ──────────────────────────────────────────────────
function Get-GitConfig($key) {
    try { git config $key 2>$null } catch { $null }
}

$DotfilesName = if ($env:GIT_AUTHOR_NAME) { $env:GIT_AUTHOR_NAME }
    elseif ($env:GIT_COMMITTER_NAME) { $env:GIT_COMMITTER_NAME }
    else { Get-GitConfig "user.name" }

$DotfilesEmail = if ($env:GIT_AUTHOR_EMAIL) { $env:GIT_AUTHOR_EMAIL }
    elseif ($env:GIT_COMMITTER_EMAIL) { $env:GIT_COMMITTER_EMAIL }
    else { Get-GitConfig "user.email" }

if (-not $DotfilesName -or -not $DotfilesEmail) {
    Write-Error @"
Could not determine name and email.

Set them via environment variables or git config:
  `$env:GIT_AUTHOR_NAME = "Your Name"
  `$env:GIT_AUTHOR_EMAIL = "you@example.com"
  .\install.ps1
"@
    exit 1
}

if ($env:CODESPACES -eq "true") {
    Write-Host "Detected GitHub Codespaces environment."
}
Write-Host "Name:  $DotfilesName"
Write-Host "Email: $DotfilesEmail"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# ── Install chezmoi ─────────────────────────────────────────────────────────
if (-not (Get-Command chezmoi -ErrorAction SilentlyContinue)) {
    Write-Host "Installing chezmoi..."
    Invoke-Expression "&{$(Invoke-RestMethod 'https://get.chezmoi.io/ps1')} -BinDir '$env:USERPROFILE\.local\bin'"
    $env:PATH = "$env:USERPROFILE\.local\bin;$env:PATH"
}

# ── Pre-populate chezmoi config to avoid prompts ────────────────────────────
$ChezmoiConfigDir = if ($env:XDG_CONFIG_HOME) { "$env:XDG_CONFIG_HOME\chezmoi" } else { "$env:USERPROFILE\.config\chezmoi" }
if (-not (Test-Path "$ChezmoiConfigDir\chezmoi.toml")) {
    New-Item -ItemType Directory -Path $ChezmoiConfigDir -Force | Out-Null
    @"
[data]
    name = "$DotfilesName"
    email = "$DotfilesEmail"
"@ | Set-Content -Path "$ChezmoiConfigDir\chezmoi.toml" -Encoding UTF8
}

# ── Apply dotfiles (run_once_ scripts handle tool installs) ─────────────────
Write-Host "Applying dotfiles..."
if ($env:DOTFILES_REPO) {
    chezmoi init --no-tty --apply $env:DOTFILES_REPO
} else {
    chezmoi init --no-tty --apply --source $ScriptDir
}

Write-Host "Done. Dotfiles applied successfully."
