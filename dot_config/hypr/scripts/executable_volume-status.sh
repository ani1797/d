#!/usr/bin/env bash
# Get current volume status for quickshell statusbar

set -euo pipefail

# Get volume info from wpctl
VOLUME_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

# Parse mute state and volume level
if [[ "$VOLUME_INFO" =~ MUTED ]]; then
    MUTED=true
    VOLUME=$(echo "$VOLUME_INFO" | awk '{print $2}')
else
    MUTED=false
    VOLUME=$(echo "$VOLUME_INFO" | awk '{print $2}')
fi

# Convert to percentage
PERCENT=$(echo "$VOLUME * 100" | bc | cut -d. -f1)

# Select icon based on volume level and mute state
if [ "$MUTED" = true ]; then
    ICON="󰖁"
    COLOR="#f7768e"
elif [ "$PERCENT" -le 33 ]; then
    ICON="󰕿"
    COLOR="#7aa2f7"
elif [ "$PERCENT" -le 66 ]; then
    ICON="󰖀"
    COLOR="#7aa2f7"
else
    ICON="󰕾"
    COLOR="#7aa2f7"
fi

# Output in format: ICON|COLOR|PERCENT
echo "${ICON}|${COLOR}|${PERCENT}"
