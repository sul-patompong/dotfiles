#!/bin/bash

# This script is run once by chezmoi to install Gemini CLI.

set -e # Exit immediately if a command exits with a non-zero status.

# Source asdf.sh to use npm from the asdf-installed nodejs
. "$HOME/.asdf/asdf.sh"

echo "Installing Gemini CLI..."

# Install Gemini CLI
if ! npm list -g | grep -q '@google/generative-ai/cli'; then
  echo "Installing Gemini CLI..."
  npm install -g @google/generative-ai/cli
else
  echo "Gemini CLI is already installed."
fi

echo "Gemini CLI installation complete."
