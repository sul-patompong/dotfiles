#!/bin/bash

# This script installs nodejs using asdf-vm.
# asdf-vm should already be installed from the packages list.

set -e

# Verify asdf is installed
if ! command -v asdf &> /dev/null; then
  echo "Error: asdf-vm is not installed. Please install it first."
  exit 1
fi

echo "asdf-vm version: $(asdf --version)"

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

# Set latest nodejs as global (system-wide)
echo "Setting latest nodejs as global..."
asdf set -u nodejs latest

echo "nodejs setup complete."
