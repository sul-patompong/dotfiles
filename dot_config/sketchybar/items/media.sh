#!/usr/bin/env bash
# System-wide nowplaying via media-control.

sketchybar --add event media_change

sketchybar --add item media right \
  --set media \
    icon.font="JetBrainsMono Nerd Font:Regular:14.0" \
    icon.color="$ACCENT" \
    icon.padding_left=12 \
    icon.padding_right=6 \
    label.font="JetBrainsMono Nerd Font:Regular:13.0" \
    label.color="$WHITE" \
    label.max_chars=24 \
    label.padding_right=12 \
    background.color="$ITEM_BG" \
    background.corner_radius=10 \
    background.height=30 \
    background.border_color="$BRACKET_BG" \
    background.border_width=1 \
    padding_left=8 padding_right=3 \
    drawing=off \
    update_freq=10 \
    script="$PLUGIN_DIR/media.sh" \
    click_script="media-control toggle" \
  --subscribe media media_change mouse.clicked
