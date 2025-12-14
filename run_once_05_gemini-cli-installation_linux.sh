#!/bin/bash

# This script is run once by chezmoi to install Gemini CLI.

set -e # Exit immediately if a command exits with a non-zero status.

# Source asdf.sh to use npm from the asdf-installed nodejs
. "$HOME/.asdf/asdf.sh"

echo "Installing Gemini CLI..."

# Install Gemini CLI
if [ ! -f "$HOME/.asdf/shims/gemini" ]; then
  echo "Installing Gemini CLI..."
  npm install -g @google/gemini-cli
else
  echo "Gemini CLI is already installed."
fi

echo "Gemini CLI installation complete."
