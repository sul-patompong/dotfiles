#!/bin/bash

# This script installs asdf-vm and nodejs on Linux.
# On Arch Linux, asdf should be installed via pacman.

set -e

# Check if asdf is already available (e.g., installed via pacman)
if command -v asdf &> /dev/null; then
  echo "asdf is already installed: $(which asdf)"
else
  # Fallback: clone asdf for non-Arch systems
  ASDF_DIR="$HOME/.asdf"
  if [ ! -d "$ASDF_DIR" ]; then
    echo "Cloning asdf-vm repository..."
    git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch v0.14.0
  fi
  # Source asdf.sh for this session
  . "$ASDF_DIR/asdf.sh"
fi

# Install nodejs plugin
if ! asdf plugin list 2>/dev/null | grep -q 'nodejs'; then
  echo "Installing asdf-nodejs plugin..."
  asdf plugin-add nodejs
else
  echo "asdf-nodejs plugin is already installed."
fi

# Install latest nodejs
echo "Installing latest version of nodejs..."
asdf install nodejs latest

# Set latest nodejs as global
echo "Setting latest nodejs as global..."
asdf set -u nodejs latest

echo "asdf-vm and nodejs setup complete."
