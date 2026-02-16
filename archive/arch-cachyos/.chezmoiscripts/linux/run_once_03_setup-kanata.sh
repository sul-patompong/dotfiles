#!/bin/bash

# Setup kanata to run at startup with proper permissions

# Check if already setup
if groups "$USER" | grep -q '\binput\b' && \
   groups "$USER" | grep -q '\buinput\b' && \
   [ -f /etc/udev/rules.d/99-kanata.rules ] && \
   [ -f /etc/modules-load.d/uinput.conf ] && \
   systemctl --user is-enabled kanata.service &>/dev/null; then
    echo "Kanata already setup, skipping."
    exit 0
fi

echo "Setting up kanata..."

# Ensure uinput group exists
sudo groupadd -f uinput

# Add user to required groups for kanata to access input devices
sudo usermod -aG input "$USER"
sudo usermod -aG uinput "$USER"

# Create udev rule for uinput access
sudo tee /etc/udev/rules.d/99-kanata.rules > /dev/null << 'EOF'
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
EOF

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
