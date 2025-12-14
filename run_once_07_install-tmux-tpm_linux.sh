#!/bin/bash

# This script is run once by chezmoi to install tmux plugin manager (TPM).

set -e # Exit immediately if a command exits with a non-zero status.

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_DIR" ]; then
  echo "Cloning tmux plugin manager (TPM)..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "TPM is already installed."
fi

echo "TPM installation complete."
echo "Note: Run 'prefix + I' inside tmux to install plugins."
