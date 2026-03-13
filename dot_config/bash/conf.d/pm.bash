# Universal package manager wrapper
# Provides: install, search, update, remove

_pm_detect() {
    if command -v brew &>/dev/null; then echo "brew"
    elif command -v apt &>/dev/null; then echo "apt"
    elif command -v dnf &>/dev/null; then echo "dnf"
    elif command -v pacman &>/dev/null; then echo "pacman"
    elif command -v apk &>/dev/null; then echo "apk"
    elif command -v zypper &>/dev/null; then echo "zypper"
    elif command -v winget.exe &>/dev/null; then echo "winget"
    else echo "unknown"
    fi
}

_PM=$(_pm_detect)

install() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: install <package> ..." >&2
        return 1
    fi
    case "$_PM" in
        brew)   brew install "$@" ;;
        apt)    sudo apt install -y "$@" ;;
        dnf)    sudo dnf install -y "$@" ;;
        pacman) sudo pacman -S --noconfirm "$@" ;;
        apk)    sudo apk add "$@" ;;
        zypper) sudo zypper install -y "$@" ;;
        winget) winget.exe install --accept-package-agreements --accept-source-agreements "$@" ;;
        *) echo "No supported package manager found" >&2; return 1 ;;
    esac
}

search() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: search <package> ..." >&2
        return 1
    fi
    case "$_PM" in
        brew)   brew search "$@" ;;
        apt)    apt search "$@" ;;
        dnf)    dnf search "$@" ;;
        pacman) pacman -Ss "$@" ;;
        apk)    apk search "$@" ;;
        zypper) zypper search "$@" ;;
        winget) winget.exe search "$@" ;;
        *) echo "No supported package manager found" >&2; return 1 ;;
    esac
}

update() {
    if [[ $# -eq 0 ]]; then
        case "$_PM" in
            brew)   brew update && brew upgrade ;;
            apt)    sudo apt update && sudo apt upgrade -y ;;
            dnf)    sudo dnf upgrade -y ;;
            pacman) sudo pacman -Syu --noconfirm ;;
            apk)    sudo apk update && sudo apk upgrade ;;
            zypper) sudo zypper refresh && sudo zypper update -y ;;
            winget) winget.exe upgrade --all ;;
            *) echo "No supported package manager found" >&2; return 1 ;;
        esac
    else
        case "$_PM" in
            brew)   brew upgrade "$@" ;;
            apt)    sudo apt install --only-upgrade -y "$@" ;;
            dnf)    sudo dnf upgrade -y "$@" ;;
            pacman) sudo pacman -S --noconfirm "$@" ;;
            apk)    sudo apk upgrade "$@" ;;
            zypper) sudo zypper update -y "$@" ;;
            winget) winget.exe upgrade "$@" ;;
            *) echo "No supported package manager found" >&2; return 1 ;;
        esac
    fi
}

remove() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: remove <package> ..." >&2
        return 1
    fi
    case "$_PM" in
        brew)   brew uninstall "$@" ;;
        apt)    sudo apt remove -y "$@" ;;
        dnf)    sudo dnf remove -y "$@" ;;
        pacman) sudo pacman -Rs --noconfirm "$@" ;;
        apk)    sudo apk del "$@" ;;
        zypper) sudo zypper remove -y "$@" ;;
        winget) winget.exe uninstall "$@" ;;
        *) echo "No supported package manager found" >&2; return 1 ;;
    esac
}
