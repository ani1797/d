# Universal package manager wrapper
# Provides: install, search, update, remove

function _pm_detect
    if type -q brew
        echo brew
    else if type -q apt
        echo apt
    else if type -q dnf
        echo dnf
    else if type -q pacman
        echo pacman
    else if type -q apk
        echo apk
    else if type -q zypper
        echo zypper
    else if type -q winget.exe
        echo winget
    else
        echo unknown
    end
end

set -g _PM (_pm_detect)

function install -d "Install packages via system package manager"
    if test (count $argv) -eq 0
        echo "Usage: install <package> ..." >&2
        return 1
    end
    switch $_PM
        case brew
            brew install $argv
        case apt
            sudo apt install -y $argv
        case dnf
            sudo dnf install -y $argv
        case pacman
            sudo pacman -S --noconfirm $argv
        case apk
            sudo apk add $argv
        case zypper
            sudo zypper install -y $argv
        case winget
            winget.exe install --accept-package-agreements --accept-source-agreements $argv
        case '*'
            echo "No supported package manager found" >&2
            return 1
    end
end

function search -d "Search for packages via system package manager"
    if test (count $argv) -eq 0
        echo "Usage: search <package> ..." >&2
        return 1
    end
    switch $_PM
        case brew
            brew search $argv
        case apt
            apt search $argv
        case dnf
            dnf search $argv
        case pacman
            pacman -Ss $argv
        case apk
            apk search $argv
        case zypper
            zypper search $argv
        case winget
            winget.exe search $argv
        case '*'
            echo "No supported package manager found" >&2
            return 1
    end
end

function update -d "Update packages via system package manager"
    if test (count $argv) -eq 0
        switch $_PM
            case brew
                brew update; and brew upgrade
            case apt
            sudo apt update; and sudo apt upgrade -y
        case dnf
                sudo dnf upgrade -y
            case pacman
                sudo pacman -Syu --noconfirm
            case apk
                sudo apk update; and sudo apk upgrade
            case zypper
                sudo zypper refresh; and sudo zypper update -y
            case winget
                winget.exe upgrade --all
            case '*'
                echo "No supported package manager found" >&2
                return 1
        end
    else
        switch $_PM
            case brew
                brew upgrade $argv
            case apt
            sudo apt install --only-upgrade -y $argv
        case dnf
                sudo dnf upgrade -y $argv
            case pacman
                sudo pacman -S --noconfirm $argv
            case apk
                sudo apk upgrade $argv
            case zypper
                sudo zypper update -y $argv
            case winget
                winget.exe upgrade $argv
            case '*'
                echo "No supported package manager found" >&2
                return 1
        end
    end
end

function remove -d "Remove packages via system package manager"
    if test (count $argv) -eq 0
        echo "Usage: remove <package> ..." >&2
        return 1
    end
    switch $_PM
        case brew
            brew uninstall $argv
        case apt
            sudo apt remove -y $argv
        case dnf
            sudo dnf remove -y $argv
        case pacman
            sudo pacman -Rs --noconfirm $argv
        case apk
            sudo apk del $argv
        case zypper
            sudo zypper remove -y $argv
        case winget
            winget.exe uninstall $argv
        case '*'
            echo "No supported package manager found" >&2
            return 1
    end
end
