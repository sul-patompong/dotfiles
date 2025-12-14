#!/bin/bash

# Setup kanata to run at startup with proper permissions

# Add user to required groups for kanata to access input devices
sudo usermod -aG input "$USER"
sudo usermod -aG uinput "$USER"

# Create udev rule for uinput access
sudo tee /etc/udev/rules.d/99-kanata.rules > /dev/null << 'EOF'
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
EOF

# Ensure uinput group exists
sudo groupadd -f uinput

# Load uinput module and make it persistent
sudo modprobe uinput
echo "uinput" | sudo tee /etc/modules-load.d/uinput.conf > /dev/null

# Reload udev rules
sudo udevadm control --reload-rules
sudo udevadm trigger

# Enable kanata service for the user
systemctl --user daemon-reload
systemctl --user enable kanata.service

echo "Kanata setup complete. Please log out and back in for group changes to take effect."
echo "After re-login, start kanata with: systemctl --user start kanata"
