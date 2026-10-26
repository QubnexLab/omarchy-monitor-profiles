# omarchy-monitor-profiles

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Omarchy](https://img.shields.io/badge/omarchy-animated-blue.svg)](https://omarchy.org)

Save, restore, and auto-sync Omarchy/Hyprland monitor configurations across wallpaper changes and reconnects.

## Features

- **Save named profiles** — `laptop`, `desk`, `vertical`, etc.
- **Auto-sync** — Wallpaper changes trigger matching profile restore
- **Native Hyprland integration** — Uses `hyprctl` for all display operations
- **Omarchy menu integration** — Access profiles from your menu
- **Watch daemon** — Background daemon monitors for display changes
- **Systemd service** — Optional systemd user service for auto-start

## Install

```bash
# Clone the repo
git clone https://github.com/QubnexLab/omarchy-monitor-profiles
cd omarchy-monitor-profiles

# Install
chmod +x install.sh
./install.sh
```

## Usage

```bash
# Save current monitor config
omarchy-monitor-profiles save desk

# Load a saved profile
omarchy-monitor-profiles load desk

# List all profiles
omarchy-monitor-profiles list

# Show current active profile
omarchy-monitor-profiles current

# Delete a profile
omarchy-monitor-profiles delete desk
```

## Auto-Sync with Wallpaper Changes

The watcher daemon automatically detects monitor changes and applies matching profiles:

```bash
# Start the watcher
omarchy-monitor-watch &

# Or use systemd
systemctl --user enable omarchy-monitor-watch
systemctl --user start omarchy-monitor-watch
```

## Omarchy Menu Integration

Add to `~/.config/omarchy/extensions/omarchy-menu.jsonc`:

```jsonc
"monitor.profiles": {"icon":"","label":"Monitor Profiles","action":"omarchy-monitor-profiles list"},
"monitor.save": {"icon":"","label":"Save Profile","action":"omarchy-monitor-profiles save"},
"monitor.load": {"icon":"","label":"Load Profile","action":"omarchy-monitor-profiles load"},
```

## Example Config

```ini
# ~/.config/omarchy/monitor-profiles/config
# Auto-start watcher on login
auto_start=true

# Default profile to load on startup
default_profile=desk
```

## License

MIT — free to use and modify.

## Demo

See the [release page](https://github.com/QubnexLab/omarchy-monitor-profiles/releases) for demo videos.

## r/omancy Post

https://www.reddit.com/r/omancy/comments/1xf0z2e/