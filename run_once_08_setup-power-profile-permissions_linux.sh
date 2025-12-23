#!/bin/bash

# Setup passwordless sudo for power profile switching
# This allows waybar to switch power profiles without password prompts

echo "Setting up permissions for power profile switching..."

# Check if platform_profile is available
if [ ! -f /sys/firmware/acpi/platform_profile ]; then
    echo "Warning: Platform profile not available on this system"
    echo "Skipping power profile permissions setup"
    exit 0
fi

# Create sudoers rule for power profile management
SUDOERS_FILE="/etc/sudoers.d/power-profile"

sudo tee "$SUDOERS_FILE" > /dev/null <<EOF
# Allow user to change ACPI platform profile without password
# Used by waybar power profile module
$USER ALL=(ALL) NOPASSWD: /usr/bin/tee /sys/firmware/acpi/platform_profile
EOF

# Set correct permissions on sudoers file
sudo chmod 0440 "$SUDOERS_FILE"

# Verify the sudoers file is valid
if sudo visudo -cf "$SUDOERS_FILE"; then
    echo "✓ Power profile permissions configured successfully"
    echo "  User '$USER' can now switch power profiles without password"
else
    echo "✗ Error: Invalid sudoers configuration"
    sudo rm -f "$SUDOERS_FILE"
    exit 1
fi
