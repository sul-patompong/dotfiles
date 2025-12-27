#!/bin/bash
# Todoist installation and Wayland configuration script
# This script runs when its content changes

set -e

echo "Installing Todoist AppImage..."

# Check if todoist-appimage is already installed
if ! yay -Q todoist-appimage &>/dev/null; then
    yay -S --noconfirm todoist-appimage
    echo "Todoist installed successfully"
else
    echo "Todoist is already installed"
fi

echo "Configuring Todoist for Wayland..."

# Ensure local applications directory exists
mkdir -p ~/.local/share/applications

# Copy system desktop file to user directory
cp -f /usr/share/applications/todoist.desktop ~/.local/share/applications/todoist.desktop

# Add Wayland flags to the desktop file
sed -i 's|Exec=env DESKTOPINTEGRATION=false /usr/bin/todoist %u --no-sandbox %U|Exec=env DESKTOPINTEGRATION=false /usr/bin/todoist %u --no-sandbox --enable-features=UseOzonePlatform --ozone-platform=wayland %U|g' ~/.local/share/applications/todoist.desktop

sed -i 's|Exec=todoist --new-window|Exec=todoist --new-window --enable-features=UseOzonePlatform --ozone-platform=wayland|g' ~/.local/share/applications/todoist.desktop

# Update desktop database
update-desktop-database ~/.local/share/applications 2>/dev/null || true

echo "Todoist configured for Wayland successfully"
