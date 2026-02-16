#!/bin/bash

# Only run on Fedora-based systems
if [ ! -f /etc/os-release ] || ! grep -qE '^ID=fedora' /etc/os-release; then
    echo "Not a Fedora system, skipping."
    exit 0
fi

# --- COPR Repos ---
sudo dnf copr enable -y atim/starship
sudo dnf copr enable -y pgdev/ghostty

# --- Third-party repos ---
# 1Password
sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'

# Brave Browser
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

# --- Install packages ---
packages=(
  git neovim tmux zsh fzf ripgrep eza
  zsh-autosuggestions zsh-syntax-highlighting
  starship ghostty
  1password brave-browser
)

sudo dnf install -y "${packages[@]}"

# --- mise (runtime manager) ---
if ! command -v mise &> /dev/null; then
  curl https://mise.run | sh
fi
mise use --global node@latest
mise use --global go@latest
mise use --global lazygit@latest

# --- Nerd Font ---
FONT_DIR="$HOME/.local/share/fonts"
if [ ! -d "$FONT_DIR/IosevkaTermNerdFont" ]; then
  mkdir -p "$FONT_DIR/IosevkaTermNerdFont"
  curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/IosevkaTerm.tar.xz \
    | tar -xJ -C "$FONT_DIR/IosevkaTermNerdFont"
  fc-cache -fv
fi

# --- Claude Code ---
if ! command -v claude &> /dev/null; then
  npm install -g @anthropic-ai/claude-code
fi

# --- Post-install setup ---
# Set zsh as default shell
if [ "$SHELL" != "/usr/bin/zsh" ]; then
  chsh -s /usr/bin/zsh
fi
