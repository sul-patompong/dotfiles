#!/bin/bash

set -e

echo "==> Installing tmux plugin manager (TPM)"

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_DIR" ]; then
    echo "==> Cloning tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo "==> TPM installed successfully!"
else
    echo "==> TPM is already installed"
fi

echo "==> TPM installation complete!"
echo "    Note: Run 'prefix + I' (Ctrl+S + I) inside tmux to install plugins"
