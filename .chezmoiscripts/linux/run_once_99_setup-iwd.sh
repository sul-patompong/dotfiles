#!/bin/bash

# This script configures iwd as standalone wireless daemon

# Create /etc/iwd directory if it doesn't exist
sudo mkdir -p /etc/iwd

# Create iwd main.conf for standalone mode
sudo tee /etc/iwd/main.conf > /dev/null << 'EOF'
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
EOF

# Disable wpa_supplicant
if systemctl is-enabled wpa_supplicant.service &>/dev/null; then
  echo "Disabling wpa_supplicant.service..."
  sudo systemctl disable --now wpa_supplicant.service
fi

# Disable NetworkManager
if systemctl is-enabled NetworkManager.service &>/dev/null; then
  echo "Disabling NetworkManager.service..."
  sudo systemctl disable --now NetworkManager.service
fi

# Enable and start iwd
if ! systemctl is-enabled iwd.service &>/dev/null; then
  echo "Enabling iwd.service..."
  sudo systemctl enable --now iwd.service
fi

# Enable systemd-resolved for DNS resolution
if ! systemctl is-enabled systemd-resolved.service &>/dev/null; then
  echo "Enabling systemd-resolved.service..."
  sudo systemctl enable --now systemd-resolved.service
fi

# Enable bluetooth service for bluetui
if ! systemctl is-enabled bluetooth.service &>/dev/null; then
  echo "Enabling bluetooth.service..."
  sudo systemctl enable --now bluetooth.service
fi

echo "iwd and bluetooth setup complete."
