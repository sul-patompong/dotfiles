#!/bin/bash
# Capture active window and open in satty for annotation

# Get the geometry of the active window
geometry=$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')

# Capture the window
grim -g "$geometry" - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png
