#!/bin/bash

# This script is run once by chezmoi to install Gemini CLI.

set -e # Exit immediately if a command exits with a non-zero status.

# Source asdf.sh to use npm from the asdf-installed nodejs
if [ -f "/opt/asdf-vm/asdf.sh" ]; then
  . "/opt/asdf-vm/asdf.sh"
elif [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
fi

echo "Installing Gemini CLI..."

# Install Gemini CLI
if [ ! -f "$HOME/.asdf/shims/gemini" ]; then
  echo "Installing Gemini CLI..."
  npm install -g @google/gemini-cli
else
  echo "Gemini CLI is already installed."
fi

echo "Gemini CLI installation complete."
