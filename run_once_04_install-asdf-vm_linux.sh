#!/bin/bash

# This script is run once by chezmoi to install asdf-vm and nodejs.

set -e # Exit immediately if a command exits with a non-zero status.

# 1. Install asdf-vm
ASDF_DIR="$HOME/.asdf"
if [ ! -d "$ASDF_DIR" ]; then
  echo "Cloning asdf-vm repository..."
  git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch v0.14.0
else
  echo "asdf-vm is already installed."
fi

# Source asdf.sh to use the asdf command
. "$ASDF_DIR/asdf.sh"

# 2. Install nodejs plugin
if ! asdf plugin list | grep -q 'nodejs'; then
  echo "Installing asdf-nodejs plugin..."
  asdf plugin-add nodejs
else
  echo "asdf-nodejs plugin is already installed."
fi

# 3. Install latest nodejs
echo "Installing latest version of nodejs..."
asdf install nodejs latest

# 4. Set latest nodejs as global
echo "Setting latest nodejs as global..."
asdf global nodejs latest

# 5. Install global npm packages
echo "Installing global npm packages..."

# Install Gemini CLI
if ! npm list -g | grep -q '@google/generative-ai/cli'; then
  echo "Installing Gemini CLI..."
  npm install -g @google/generative-ai/cli
else
  echo "Gemini CLI is already installed."
fi

# Install Claude CLI
if ! npm list -g | grep -q '@anthropic-ai/cli'; then
  echo "Installing Claude CLI..."
  npm install -g @anthropic-ai/cli
else
  echo "Claude CLI is already installed."
fi

echo "asdf-vm and nodejs setup complete."
