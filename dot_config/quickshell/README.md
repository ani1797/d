# Quickshell Bar Configuration

A minimal, modern status bar for Hyprland using Quickshell.

## Features

- **Workspace indicators**: Visual pills showing active and occupied workspaces (1-9)
- **Clock**: Center-aligned time display with date on click
- **System tray**: Volume control and date display
- **Tokyo Night theme**: Matching your Hyprland color scheme

## Structure

```
quickshell/
├── shell.qml        # Main entry point - creates bar on each monitor
├── Bar.qml          # Bar container with layout
├── Workspaces.qml   # Workspace indicator pills
├── Clock.qml        # Center clock widget
└── SystemTray.qml   # Right-side system indicators
```

## Requirements

- `quickshell-git` (installed via AUR)
- `JetBrainsMono Nerd Font` for icons
- `pavucontrol` (optional, for volume control)

## Usage

Quickshell is started automatically by Hyprland (see `conf.d/autostart.conf`).

To reload after changes:
```bash
pkill quickshell && quickshell &
```

To test configuration:
```bash
quickshell --config ~/.config/quickshell
```

## Customization

### Change bar height
Edit `shell.qml`:
```qml
height: 36  // Change this value
```

### Modify colors
All components use Tokyo Night palette:
- Background: `#1a1b26`
- Foreground: `#c0caf5`
- Blue: `#7aa2f7`
- Magenta: `#bb9af7`
- Comment: `#565f89`

### Add more widgets
Create a new `.qml` file and import it in `Bar.qml`:
```qml
MyWidget {
    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
}
```

## Troubleshooting

### Bar not appearing
1. Check if quickshell is running: `pgrep quickshell`
2. Check logs: `journalctl --user -u quickshell -f`
3. Test config: `quickshell --config ~/.config/quickshell`

### Workspace indicators not updating
Ensure Hyprland IPC socket is accessible:
```bash
ls -la $XDG_RUNTIME_DIR/hypr/
```

### Font icons not showing
Install Nerd Fonts:
```bash
yay -S ttf-jetbrains-mono-nerd
```
Then reload quickshell.

## Migration from Waybar

Waybar has been replaced with Quickshell for:
- Better Hyprland integration (native IPC)
- QML-based configuration (more powerful)
- Lower resource usage
- Smoother animations

Key differences:
- No JSON config needed
- Workspace switching via click (not scroll)
- Simpler module system
