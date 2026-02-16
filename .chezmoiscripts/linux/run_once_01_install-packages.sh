#!/bin/bash

# Only run on Fedora-based systems
if [ ! -f /etc/os-release ] || ! grep -qE '^ID=fedora' /etc/os-release; then
    echo "Not a Fedora system, skipping."
    exit 0
fi

# --- COPR Repos ---
sudo dnf copr enable -y atim/starship
sudo dnf copr enable -y dejan/lazygit
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
  starship lazygit ghostty
  1password brave-browser
  jetbrains-mono-fonts
)

sudo dnf install -y "${packages[@]}"

# --- Post-install setup ---
# Set zsh as default shell
if [ "$SHELL" != "/usr/bin/zsh" ]; then
  chsh -s /usr/bin/zsh
fi

# --- Manual installs (not in repos) ---
# Kanata: cargo install kanata (or download from GitHub releases)
# Claude Code: npm install -g @anthropic-ai/claude-code
# Docker: sudo dnf install docker docker-compose && sudo systemctl enable --now docker.service
