#!/bin/bash

HYPR_CONFIG_FILE="$HOME/.config/hypr/hyprland.conf"
CUSTOM_SOURCE_LINE="source = ~/.config/hypr/mycustom-overrides.conf"

# Check if the custom source line already exists in the hyprland.conf file
if ! grep -qF "$CUSTOM_SOURCE_LINE" "$HYPR_CONFIG_FILE"; then
  echo "" >>"$HYPR_CONFIG_FILE" # Add a newline for separation if needed
  echo "$CUSTOM_SOURCE_LINE" >>"$HYPR_CONFIG_FILE"
  echo "Added custom Hyprland source line to $HYPR_CONFIG_FILE"
else
  echo "Custom Hyprland source line already exists in $HYPR_CONFIG_FILE"
fi
