#!/usr/bin/env bash

sketchybar --add item battery right \
  --set battery \
    icon.font="JetBrainsMono Nerd Font:Regular:16.0" \
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
    popup.background.color="$ITEM_BG" \
    popup.background.corner_radius=8 \
    popup.background.border_color="$ACCENT" \
    popup.background.border_width=1 \
    popup.align=center \
    update_freq=120 \
    script="$PLUGIN_DIR/battery.sh" \
    click_script="sketchybar --set battery popup.drawing=toggle" \
  --subscribe battery system_woke power_source_change mouse.clicked

# Popup rows
for row in status time cycles; do
  sketchybar --add item "battery.popup.$row" popup.battery \
    --set "battery.popup.$row" \
      icon.drawing=off \
      label.font="JetBrainsMono Nerd Font:Regular:12.0" \
      label.color="$WHITE" \
      label.padding_left=10 \
      label.padding_right=10 \
      background.color="$TRANSPARENT"
done
