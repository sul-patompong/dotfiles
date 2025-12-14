#!/bin/bash

# This script is run once by chezmoi to install the .NET environment for the Exio project.
# It will prompt for confirmation before starting the installation.

set -e # Exit immediately if a command exits with a non-zero status.

# Prompt for user confirmation
read -p "This is the .NET environment installation specific for the Exio project. Do you want to continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Skipping .NET environment installation."
    exit 0
fi

# Source asdf.sh to use the asdf command
. "$HOME/.asdf/asdf.sh"

# 1. Install dotnet plugin
if ! asdf plugin list | grep -q 'dotnet'; then
  echo "Installing asdf-dotnet plugin..."
  asdf plugin-add dotnet
else
  echo "asdf-dotnet plugin is already installed."
fi

# 2. Install .NET versions
echo "Installing .NET SDKs..."
asdf install dotnet 8.0

# Install latest .NET 9 preview
latest_preview=$(asdf list-all dotnet | grep "9.0.0-preview" | tail -n 1 || true)
if [ -n "$latest_preview" ]; then
  echo "Installing latest .NET 9 preview: $latest_preview"
  asdf install dotnet "$latest_preview"
else
  echo "Could not find a preview version of .NET 9."
fi


# 3. Set .NET 8 as global
echo "Setting .NET 8.0 as global..."
asdf global dotnet 8.0

# 4. Install swagger-cli
echo "Installing swagger-cli..."
if ! npm list -g | grep -q 'swagger-cli@6.5.0'; then
  npm install -g swagger-cli@6.5.0
else
  echo "swagger-cli@6.5.0 is already installed."
fi

echo ".NET setup for Exio project complete."
