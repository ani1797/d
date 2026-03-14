#!/usr/bin/env bash
# Wallpaper rotation script for swww
# Randomly selects and displays wallpapers from ~/Pictures/Wallpapers/

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
TRANSITION_TYPE="fade"
TRANSITION_DURATION=2  # seconds

# Ensure swww daemon is running
if ! pgrep -x swww-daemon > /dev/null; then
    swww-daemon &
    sleep 1
fi

# Get all image files from wallpaper directory
mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null)

# Check if any wallpapers were found
if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Select a random wallpaper
random_wallpaper="${wallpapers[$RANDOM % ${#wallpapers[@]}]}"

# Set the wallpaper with swww
swww img "$random_wallpaper" \
    --transition-type "$TRANSITION_TYPE" \
    --transition-duration "$TRANSITION_DURATION"

echo "Wallpaper set to: $random_wallpaper"
