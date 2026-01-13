#!/bin/bash

set -e

echo "==> Setting up asdf-vm for macOS"

# Verify asdf is installed
if ! command -v asdf &> /dev/null; then
    echo "Error: asdf is not installed. Please run the package installation script first."
    exit 1
fi

echo "==> asdf-vm version: $(asdf --version)"

# Add asdf to fish shell if not already configured
FISH_CONFIG="$HOME/.config/fish/config.fish"
if [ -f "$FISH_CONFIG" ]; then
    if ! grep -q "asdf" "$FISH_CONFIG"; then
        echo "==> Adding asdf to fish shell configuration..."
        echo "" >> "$FISH_CONFIG"
        echo "# asdf version manager" >> "$FISH_CONFIG"
        echo "source $(brew --prefix asdf)/libexec/asdf.fish" >> "$FISH_CONFIG"
    else
        echo "==> asdf is already configured in fish"
    fi
fi

# Source asdf for this script
source "$(brew --prefix asdf)/libexec/asdf.sh"

# Install nodejs plugin
if ! asdf plugin list 2>/dev/null | grep -q 'nodejs'; then
    echo "==> Installing asdf-nodejs plugin..."
    asdf plugin add nodejs
else
    echo "==> asdf-nodejs plugin is already installed"
fi

# Install latest nodejs
echo "==> Installing latest version of nodejs..."
asdf install nodejs latest

# Set latest nodejs as global
echo "==> Setting latest nodejs as global..."
asdf global nodejs latest

echo "==> nodejs setup complete"
echo "    Node version: $(asdf current nodejs 2>/dev/null | awk '{print $2}')"
echo "    Note: Restart your shell for changes to take effect"
