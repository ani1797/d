# Dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

## Setup

### Install chezmoi and apply dotfiles

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ani1797
```

### Manual setup

```sh
# Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"

# Initialize from this repo
chezmoi init https://github.com/ani1797/dotfiles.git

# Preview changes
chezmoi diff

# Apply
chezmoi apply
```

## Compatibility

### Tools

| Tool | Linux | macOS | Windows |
|------|:-----:|:-----:|:-------:|
| [chezmoi](https://www.chezmoi.io/) | ✅ | ✅ | ✅ |
| [starship](https://starship.rs/) | ✅ | ✅ | ✅ |
| [direnv](https://direnv.net/) | ✅ | ✅ | ✅ |
| [fnm](https://github.com/Schniz/fnm) | ✅ | ✅ | ✅ |
| [npm](https://www.npmjs.com/) | ✅ | ✅ | ✅ |
| [uv](https://github.com/astral-sh/uv) | ✅ | ✅ | ✅ |
| [gh + Copilot](https://cli.github.com/) | ✅ | ✅ | ✅ |
| [tmux](https://github.com/tmux/tmux) | ✅ | ✅ | — (WSL) |
| [fzf](https://github.com/junegunn/fzf) | ✅ | ✅ | ✅ |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | ✅ | ✅ | ✅ |
| [fd](https://github.com/sharkdp/fd) | ✅ | ✅ | ✅ |
| [bat](https://github.com/sharkdp/bat) | ✅ | ✅ | ✅ |
| [eza](https://github.com/eza-community/eza) | ✅ | ✅ | ✅ |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | ✅ | ✅ | ✅ |
| [delta](https://github.com/dandavison/delta) | ✅ | ✅ | ✅ |
| [yazi](https://github.com/sxyazi/yazi) | ✅ (Arch) | — | — |

### Terminal Emulators

| Terminal | Linux | macOS | Windows |
|----------|:-----:|:-----:|:-------:|
| [kitty](https://sw.kovidgoyal.net/kitty/) | ✅ | ✅ | — |
| [alacritty](https://alacritty.org/) | ✅ | ✅ | ✅ |
| [ghostty](https://ghostty.org/) | ✅ | ✅ | ✅ |

All terminal configurations use the Tokyo Night theme to match the overall system aesthetic.

### Fonts

| Font | Linux | macOS | Windows |
|------|:-----:|:-----:|:-------:|
| [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) | ✅ | ✅ | ✅ |

Fonts are automatically installed via chezmoi scripts on first setup.

### Shells

| Shell | Linux | macOS | Windows |
|-------|:-----:|:-----:|:-------:|
| bash | ✅ | ✅ | ✅ (Git Bash) |
| zsh | ✅ | ✅ | — |
| fish | ✅ | ✅ | — |
| PowerShell | — | — | ✅ |

### Shell Integrations

| Integration | bash | zsh | fish | PowerShell |
|-------------|:----:|:---:|:----:|:----------:|
| starship | ✅ | ✅ | ✅ | ✅ |
| direnv | ✅ | ✅ | ✅ | — |
| fnm | ✅ | ✅ | ✅ | ✅ |
| fzf | ✅ | ✅ | ✅ | — |
| eza/bat/zoxide | ✅ | ✅ | ✅ | — |

## Usage

```sh
# Add a dotfile
chezmoi add ~/.bashrc

# Edit a managed file
chezmoi edit ~/.bashrc

# See what would change
chezmoi diff

# Apply changes
chezmoi apply

# Pull latest and apply
chezmoi update
```
