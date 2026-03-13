# Hyprland Configuration Updates

## 2026-03-13 - Fixed Errors & Migrated to Quickshell

### Configuration Errors Fixed

#### 1. **Input Configuration** (`conf.d/input.conf`)
- ❌ `tap-to-click` → ✅ `tap_to_click`
  - Hyprland 0.54+ uses underscores instead of hyphens

#### 2. **Appearance/Blur** (`conf.d/appearance.conf`)
- ❌ Removed deprecated `new_optimizations` property
- ❌ Removed deprecated `xray` property
  - These options were removed in Hyprland 0.54+

#### 3. **Appearance/Shadows** (`conf.d/appearance.conf`)
- ❌ Old nested syntax:
  ```
  shadow {
      enabled = true
      range = 15
      render_power = 3
      color = rgba(...)
  }
  ```
- ✅ New flat syntax:
  ```
  drop_shadow = true
  shadow_range = 15
  shadow_render_power = 3
  col.shadow = rgba(...)
  ```

#### 4. **Dwindle Layout** (`conf.d/appearance.conf`)
- ❌ Removed deprecated `smart_resizing` property
  - No longer supported in Hyprland 0.54+

#### 5. **Master Layout** (`conf.d/appearance.conf`)
- ❌ `new_status = master` → ✅ `new_on_top = false`
  - Property was renamed

#### 6. **Keybinds** (`conf.d/keybinds.conf`)
- Removed `-theme tokyo-night` from rofi calls (theme doesn't exist)
- Fixed lock screen keybind conflict: `$mod, L` → `$mod SHIFT, L`
  - Prevents conflict with focus movement (hjkl navigation)
- Updated lock command: `hyprlock || loginctl lock-session`

### Quickshell Migration

Replaced Waybar with Quickshell for better Hyprland integration:

#### Created Configuration Files:
1. **`quickshell/shell.qml`** - Main entry point
   - Creates bar on each monitor
   - 36px height with 4px margins
   - Tokyo Night theme

2. **`quickshell/Bar.qml`** - Bar container
   - Rounded corners (8px radius)
   - Three-section layout (left/center/right)

3. **`quickshell/Workspaces.qml`** - Workspace indicators
   - 9 workspace pills (animated)
   - Active workspace highlighted in blue
   - Clickable to switch workspaces
   - Hover effects

4. **`quickshell/Clock.qml`** - Center clock
   - HH:mm format by default
   - Click to toggle date display
   - Updates every second

5. **`quickshell/SystemTray.qml`** - System indicators
   - Volume control (click to open pavucontrol)
   - Date display
   - Minimal, clean design

6. **`quickshell/README.md`** - Documentation
   - Setup instructions
   - Customization guide
   - Troubleshooting tips

### Scripts Added

1. **`scripts/validate-config.sh`** - Configuration validator
   - Checks for missing files
   - Detects deprecated syntax
   - Verifies required binaries
   - Tests configuration syntax

### Installation Updates

The installation script (`run_onchange_install-hyprland.sh.tmpl`) already includes:
- `quickshell-git` via AUR (yay/paru)
- All required dependencies
- Proper error checking

### Benefits of Migration

**Quickshell vs Waybar:**
- ✅ Native Hyprland IPC integration
- ✅ QML-based configuration (more powerful)
- ✅ Lower resource usage
- ✅ Smoother animations
- ✅ Better workspace integration
- ✅ No JSON config needed

### Testing

Configuration has been validated and reloaded:
```bash
hyprctl reload  # ✅ ok
quickshell      # ✅ running
```

Screenshot captured at: `/tmp/hyprland-screenshots/hyprland-quickshell-*.png`

### Next Steps

To verify the setup:
```bash
# Check configuration
~/.config/hypr/scripts/validate-config.sh

# Reload Hyprland
hyprctl reload

# Restart quickshell
pkill quickshell && quickshell &

# Take screenshot
grim ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png
```

### Compatibility

- **Hyprland**: 0.54.2+ (tested)
- **Quickshell**: git version (AUR: quickshell-git)
- **OS**: Arch Linux

### References

- Hyprland 0.54 changelog: Breaking changes for shadow/blur syntax
- Quickshell docs: QML component API
- Tokyo Night theme: Color palette maintained across all components
