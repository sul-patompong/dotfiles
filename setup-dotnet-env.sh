#!/bin/bash

# Manual script to set up .NET development environment:
# - .NET SDK 8.0 (main)
# - .NET SDK 7.0
# - Swagger CLI 6.5.0 (global dotnet tool)
# - Azure CLI
# - JetBrains Toolbox
#
# Usage: ./setup-dotnet-env.sh

set -e

echo "=== Setting up .NET Development Environment ==="

# Ensure yay is available
if ! command -v yay &>/dev/null; then
  echo "Error: yay is required. Please install yay first."
  exit 1
fi

# Packages to install via yay
packages=(
  "dotnet-sdk-8.0"
  "dotnet-sdk-7.0"
  "azure-cli"
  "jetbrains-toolbox"
)

# Filter out already installed packages
to_install=()
for pkg in "${packages[@]}"; do
  if ! pacman -Q "$pkg" &>/dev/null; then
    to_install+=("$pkg")
  else
    echo "Package $pkg is already installed."
  fi
done

# Install missing packages
if [ ${#to_install[@]} -gt 0 ]; then
  echo "Installing: ${to_install[*]}"
  yay -S --noconfirm "${to_install[@]}"
else
  echo "All system packages already installed."
fi

# Set .NET 8 as the default version
echo "Setting .NET 8 as the default SDK version..."
if [ ! -f "$HOME/global.json" ]; then
  cat > "$HOME/global.json" << 'EOF'
{
  "sdk": {
    "version": "8.0.0",
    "rollForward": "latestFeature"
  }
}
EOF
  echo "Created global.json with .NET 8 as default."
else
  echo "global.json already exists, skipping."
fi

# Install Swagger CLI 6.5.0 as global dotnet tool
echo "Installing Swagger CLI (Swashbuckle.AspNetCore.Cli) version 6.5.0..."
if dotnet tool list -g 2>/dev/null | grep -q "swashbuckle.aspnetcore.cli"; then
  echo "Swagger CLI is already installed. Updating to version 6.5.0..."
  dotnet tool update -g Swashbuckle.AspNetCore.Cli --version 6.5.0
else
  dotnet tool install -g Swashbuckle.AspNetCore.Cli --version 6.5.0
  echo "Swagger CLI 6.5.0 installed successfully."
fi

# Ensure dotnet tools path is in PATH (fish shell)
DOTNET_TOOLS_PATH="$HOME/.dotnet/tools"
if [[ ":$PATH:" != *":$DOTNET_TOOLS_PATH:"* ]]; then
  echo ""
  echo "NOTE: Add the following to your ~/.config/fish/config.fish:"
  echo "  fish_add_path $DOTNET_TOOLS_PATH"
fi

echo ""
echo "=== .NET Environment Setup Complete ==="
echo "Installed SDKs:"
dotnet --list-sdks
echo ""
echo "Global dotnet tools:"
dotnet tool list -g
