#!/bin/bash

set -e

echo "==> Setting up macOS development environment"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "==> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo "==> Adding Homebrew to PATH for Apple Silicon..."
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "==> Homebrew is already installed"
fi

# Update Homebrew
echo "==> Updating Homebrew..."
brew update || echo "Warning: Homebrew update failed, continuing..."

# Add Anthropic tap for Claude Code
echo "==> Adding Anthropic tap..."
brew tap anthropics/claude || echo "Warning: Failed to tap anthropics/claude, continuing..."

# Add nikitabobko tap for AeroSpace
echo "==> Adding nikitabobko tap for AeroSpace..."
brew tap nikitabobko/tap || echo "Warning: Failed to tap nikitabobko/tap, continuing..."

# Install packages
echo "==> Installing packages..."
packages=(
    git
    neovim
    ripgrep
    fzf
    starship
    tmux
    eza
    lazygit
    asdf
    claude-code
    kanata
    gemini-cli
    zsh-autosuggestions
    zsh-syntax-highlighting
)

for package in "${packages[@]}"; do
    if brew list "$package" &> /dev/null; then
        echo "==> $package is already installed"
    else
        echo "==> Installing $package..."
        brew install "$package"
    fi
done

# Install applications
echo "==> Installing applications..."
apps=(
    ghostty
    aerospace
)

for app in "${apps[@]}"; do
    if brew list --cask "$app" &> /dev/null; then
        echo "==> $app is already installed"
    else
        echo "==> Installing $app..."
        brew install --cask "$app"
    fi
done

# Install fonts
echo "==> Installing fonts..."
fonts=(
    font-iosevka-term-nerd-font
)

for font in "${fonts[@]}"; do
    if brew list --cask "$font" &> /dev/null; then
        echo "==> $font is already installed"
    else
        echo "==> Installing $font..."
        brew install --cask "$font"
    fi
done

echo "==> macOS development environment setup complete!"
