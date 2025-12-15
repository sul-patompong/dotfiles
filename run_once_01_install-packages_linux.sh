#!/bin/bash

# This script is run once by chezmoi to install packages.

# First, ensure yay is installed
if ! command -v yay &>/dev/null; then
  echo "yay could not be found, installing..."
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
  rm -rf /tmp/yay
fi

# Add the packages you want to install to this list.
packages=(
  "git"
  "neovim"
  "tmux"
  "zsh"
  "obsidian-bin"
  "fzf"
  "ripgrep"
  "starship"
  "waybar"
  "hyprpaper"
  "hypridle"
  "hyprlock"
  "brightnessctl"
  "ghostty-git"
  "kanata"
  "eza"
  "lazygit"
  "ttf-iosevka-nerd" # Added for IDE and terminal font
  "ttf-jetbrains-mono-nerd"
  "ttf-sarabun" # Added as per user request
  "1password"
  "brave-bin"
  "claude-code"
  "azure-cli"
  "impala"
  "iwd"
  "bluetui"
  "bluez"
  "bluez-utils"
  "wiremix"
  "slack-desktop-wayland"
  "fish"
)

# Filter out already installed packages
to_install=()
for pkg in "${packages[@]}"; do
  if ! pacman -Q "$pkg" &>/dev/null; then
    to_install+=("$pkg")
  fi
done

# Install only missing packages
if [ ${#to_install[@]} -gt 0 ]; then
  echo "Installing: ${to_install[*]}"
  yay -S --noconfirm "${to_install[@]}"
else
  echo "All packages already installed."
fi

# Set system language to English (US)
echo "Setting system language to English..."
sudo sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen
echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf

# Set fish as default shell
if [ "$SHELL" != "/usr/bin/fish" ]; then
  echo "Setting fish as default shell..."
  chsh -s /usr/bin/fish
else
  echo "fish is already the default shell."
fi
