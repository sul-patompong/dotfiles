#!/bin/bash

# Only run on Fedora-based systems
if [ ! -f /etc/os-release ] || ! grep -qE '^ID=fedora' /etc/os-release; then
    echo "Not a Fedora system, skipping."
    exit 0
fi

# NOTE: System packages, repos, zsh default shell, and 1Password CLI
# are managed by Ansible (setup-server.yml). This script only handles
# user-level tools.

# --- mise (runtime manager) ---
MISE="$HOME/.local/bin/mise"
if [ ! -f "$MISE" ]; then
  curl https://mise.run | sh
fi
eval "$($MISE activate bash)"
$MISE use --global node@latest
$MISE use --global go@latest
$MISE use --global lazygit@latest
$MISE use --global eza@latest
$MISE use --global npm:@anthropic-ai/claude-code@latest

# --- Nerd Font ---
FONT_DIR="$HOME/.local/share/fonts"
if [ ! -d "$FONT_DIR/IosevkaTermNerdFont" ]; then
  mkdir -p "$FONT_DIR/IosevkaTermNerdFont"
  curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/IosevkaTerm.tar.xz \
    | tar -xJ -C "$FONT_DIR/IosevkaTermNerdFont"
  fc-cache -fv
fi
