#!/usr/bin/env bash

sketchybar --add item cpu right \
  --set cpu \
    icon="$ICON_CPU" \
    icon.font="JetBrainsMono Nerd Font:Regular:14.0" \
    icon.color="$WHITE" \
    icon.padding_left=10 \
    icon.padding_right=4 \
    label.font="JetBrainsMono Nerd Font:Regular:13.0" \
    label.color="$WHITE" \
    label.padding_right=10 \
    background.color="$ITEM_BG" \
    background.corner_radius=10 \
    background.height=30 \
    background.border_color="$BRACKET_BG" \
    background.border_width=1 \
    padding_left=3 padding_right=3 \
    update_freq=5 \
    script="$PLUGIN_DIR/cpu.sh"
