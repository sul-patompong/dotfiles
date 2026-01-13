#!/bin/bash

set -e

echo "==> Setting up fish shell as default"

# Check if fish is installed
if ! command -v fish &> /dev/null; then
    echo "Error: fish is not installed. Please run the package installation script first."
    exit 1
fi

# Get the path to fish
FISH_PATH=$(which fish)
echo "==> Found fish at: $FISH_PATH"

# Add fish to /etc/shells if not already there
if ! grep -q "^$FISH_PATH$" /etc/shells; then
    echo "==> Adding fish to /etc/shells..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells > /dev/null
else
    echo "==> fish is already in /etc/shells"
fi

# Set fish as default shell
if [ "$SHELL" != "$FISH_PATH" ]; then
    echo "==> Setting fish as default shell..."
    chsh -s "$FISH_PATH"
    echo "==> fish is now your default shell!"
    echo "    Please log out and log back in for changes to take effect."
else
    echo "==> fish is already your default shell"
fi

echo "==> Fish shell setup complete!"
