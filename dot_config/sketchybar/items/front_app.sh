#!/usr/bin/env bash

sketchybar --add item front_app q \
  --set front_app \
    icon.font="sketchybar-app-font:Regular:16.0" \
    icon.color="$ACCENT" \
    icon.padding_left=12 \
    icon.padding_right=6 \
    icon.y_offset=-1 \
    label.font="JetBrainsMono Nerd Font:SemiBold:13.0" \
    label.color="$WHITE" \
    label.padding_right=12 \
    background.color="$ITEM_BG" \
    background.corner_radius=10 \
    background.height=30 \
    background.border_color="$BRACKET_BG" \
    background.border_width=1 \
    padding_left=3 padding_right=20 \
    script="$PLUGIN_DIR/front_app.sh" \
  --subscribe front_app front_app_switched
