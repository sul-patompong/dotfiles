#!/usr/bin/env bash

sketchybar --add event keyboard_change

sketchybar --add item keyboard right \
  --set keyboard \
    icon.drawing=off \
    label.font="JetBrainsMono Nerd Font:Bold:13.0" \
    label.color="$WHITE" \
    label.padding_left=10 \
    label.padding_right=10 \
    background.color="$ITEM_BG" \
    background.corner_radius=10 \
    background.height=30 \
    background.border_color="$BRACKET_BG" \
    background.border_width=1 \
    padding_left=3 padding_right=3 \
    script="$PLUGIN_DIR/keyboard.sh" \
  --subscribe keyboard keyboard_change
