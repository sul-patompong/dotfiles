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

# --- Nerd Fonts ---
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

install_nerd_font() {
  local font_name="$1"
  if fc-list | grep -qi "$font_name"; then
    echo "==> $font_name already installed, skipping."
    return
  fi
  echo "==> Installing $font_name Nerd Font..."
  local url
  url=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
    | grep "browser_download_url" | grep "${font_name}.tar.xz" | cut -d '"' -f 4)
  curl -fsSL "$url" | tar -xJ -C "$FONT_DIR"
  fc-cache -f "$FONT_DIR"
}

install_nerd_font "VictorMono"

# --- Ghostty terminal ---
if ! command -v ghostty &>/dev/null; then
  echo "==> Installing Ghostty..."
  sudo dnf copr enable -y scottames/ghostty
  sudo dnf install -y ghostty
fi

# --- Brave Browser ---
if ! command -v brave-browser &>/dev/null; then
  echo "==> Installing Brave Browser..."
  curl -fsS https://dl.brave.com/install.sh | sh
fi
