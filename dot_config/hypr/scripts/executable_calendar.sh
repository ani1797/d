#!/usr/bin/env bash
# Display calendar in rofi popup

set -euo pipefail

# Tokyo Night themed calendar popup
THEME_OVERRIDE='
window {
    width: 300px;
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
    background-color: transparent;
}
element {
    padding: 2px;
    background-color: transparent;
    text-color: #c0caf5;
}
element selected {
    background-color: #24283b;
    text-color: #7aa2f7;
}
element-text {
    background-color: inherit;
    text-color: inherit;
    font: "JetBrainsMono Nerd Font Mono 10";
}
inputbar {
    enabled: false;
}
'

# Display calendar
cal | rofi -dmenu -p "Calendar" -theme-str "$THEME_OVERRIDE"
