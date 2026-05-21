#!/usr/bin/env bash

sketchybar --add item wifi right \
  --set wifi \
    icon.font="JetBrainsMono Nerd Font:Regular:16.0" \
    icon.color="$WHITE" \
    icon.padding_left=10 icon.padding_right=10 \
    label.drawing=off \
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
    update_freq=30 \
    script="$PLUGIN_DIR/wifi.sh" \
    click_script="sketchybar --set wifi popup.drawing=toggle" \
  --subscribe wifi wifi_change system_woke mouse.clicked

for row in ssid ip router rssi; do
  sketchybar --add item "wifi.popup.$row" popup.wifi \
    --set "wifi.popup.$row" \
      icon.drawing=off \
      label.font="JetBrainsMono Nerd Font:Regular:12.0" \
      label.color="$WHITE" \
      label.padding_left=10 \
      label.padding_right=10 \
      background.color="$TRANSPARENT"
done
