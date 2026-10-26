#!/usr/bin/env bash
# omarchy-monitor-profiles - Install script
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${XDG_BIN_HOME:-$HOME/.local/bin}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/omarchy/monitor-profiles"

echo "=== Omarchy Monitor Profiles Installer ==="
echo ""

# Create directories
mkdir -p "$BIN_DIR"
mkdir -p "$CONFIG_DIR/profiles"

# Install binaries
echo "Installing binaries to $BIN_DIR..."
install -m 755 "$REPO_DIR/bin/omarchy-monitor-profiles" "$BIN_DIR/omarchy-monitor-profiles"
install -m 755 "$REPO_DIR/bin/omarchy-monitor-watch" "$BIN_DIR/omarchy-monitor-watch"

# Install systemd service (optional)
if command -v systemctl &>/dev/null; then
    echo "Installing systemd user service..."
    mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
    cp "$REPO_DIR/systemd/omarchy-monitor-watch.service" "${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user/"
    systemctl --user daemon-reload 2>/dev/null || true
    echo "  Run: systemctl --user enable --now omarchy-monitor-watch.service"
fi

# Create default config
if [[ ! -f "$CONFIG_DIR/config" ]]; then
    cat > "$CONFIG_DIR/config" <<EOF
# Omarchy Monitor Profiles Config
# Auto-start watcher on login
auto_start=true

# Default profile to load on startup
default_profile=desk
EOF
    echo "Created config at $CONFIG_DIR/config"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Usage:"
echo "  omarchy-monitor-profiles save <name>   - Save current monitor config"
echo "  omarchy-monitor-profiles load <name>   - Load a saved profile"
echo "  omarchy-monitor-profiles list           - List all profiles"
echo ""
echo "To enable auto-switching:"
echo "  systemctl --user enable --now omarchy-monitor-watch.service"