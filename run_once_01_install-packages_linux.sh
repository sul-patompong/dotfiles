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
  "ghostty"
  "kanata"
  "lazygit"
)

# Update the system and install the packages using yay
yay -S --noconfirm "${packages[@]}"
