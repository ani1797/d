#!/usr/bin/env bash
# Power menu for Hyprland using rofi

set -euo pipefail

# Tokyo Night color scheme for rofi
THEME_OVERRIDE='
window {
    width: 250px;
    background-color: #1a1b26;
    border: 2px;
    border-color: #7aa2f7;
    border-radius: 8px;
    padding: 10px;
}
mainbox {
    background-color: transparent;
}
listview {
    lines: 5;
    background-color: transparent;
}
element {
    padding: 8px;
    background-color: transparent;
    text-color: #c0caf5;
    border-radius: 4px;
}
element selected {
    background-color: #24283b;
    text-color: #7aa2f7;
}
element-text {
    background-color: inherit;
    text-color: inherit;
}
inputbar {
    enabled: false;
}
'

# Menu options with icons
OPTIONS=(
    "󰌾 Lock"
    "󰍃 Logout"
    "󰤄 Suspend"
    "󰑓 Restart"
    "󰐥 Shutdown"
)

# Display menu and get selection
SELECTED=$(printf '%s\n' "${OPTIONS[@]}" | rofi -dmenu -p "Power Menu" -theme-str "$THEME_OVERRIDE")

# Execute based on selection
case "$SELECTED" in
    "󰌾 Lock")
        loginctl lock-session
        ;;
    "󰍃 Logout")
        hyprctl dispatch exit
        ;;
    "󰤄 Suspend")
        systemctl suspend
        ;;
    "󰑓 Restart")
        systemctl reboot
        ;;
    "󰐥 Shutdown")
        systemctl poweroff
        ;;
    *)
        # User cancelled or invalid selection
        exit 0
        ;;
esac
