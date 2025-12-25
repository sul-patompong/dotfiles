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
  "swayosd"
  "mako"
  "docker"
  "docker-compose"
  "tlp"
  "tlp-rdw"
  "satty"
  "grim"
  "slurp"
  "wl-clipboard"
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

# Enable swayosd-libinput-backend service (for caps-lock/num-lock OSD)
if ! systemctl is-enabled swayosd-libinput-backend.service &>/dev/null; then
  echo "Enabling swayosd-libinput-backend service..."
  sudo systemctl enable --now swayosd-libinput-backend.service
else
  echo "swayosd-libinput-backend service is already enabled."
fi

# Enable Docker service
if ! systemctl is-enabled docker.service &>/dev/null; then
  echo "Enabling Docker service..."
  sudo systemctl enable --now docker.service
else
  echo "Docker service is already enabled."
fi

# Add current user to docker group (allows running docker without sudo)
if ! groups "$USER" | grep -q docker; then
  echo "Adding $USER to docker group..."
  sudo usermod -aG docker "$USER"
  echo "Note: Log out and back in for docker group changes to take effect."
else
  echo "$USER is already in the docker group."
fi

# Disable power-profiles-daemon if it exists (conflicts with TLP)
if systemctl is-active power-profiles-daemon.service &>/dev/null; then
  echo "Disabling power-profiles-daemon (conflicts with TLP)..."
  sudo systemctl stop power-profiles-daemon.service
  sudo systemctl disable power-profiles-daemon.service
  sudo systemctl mask power-profiles-daemon.service
fi

# Enable TLP service (for advanced power management)
if ! systemctl is-active tlp.service &>/dev/null; then
  echo "Enabling TLP service..."
  sudo systemctl enable --now tlp.service
else
  echo "TLP service is already active."
fi

# Enable TLP RDW (Radio Device Wizard) service if it exists
if systemctl list-unit-files tlp-rdw.service &>/dev/null; then
  if ! systemctl is-active tlp-rdw.service &>/dev/null; then
    echo "Enabling TLP-RDW service..."
    sudo systemctl enable --now tlp-rdw.service
  else
    echo "TLP-RDW service is already active."
  fi
else
  echo "TLP-RDW service not available (this is optional, TLP will work without it)."
fi
