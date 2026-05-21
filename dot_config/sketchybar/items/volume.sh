#!/usr/bin/env bash

sketchybar --add item volume right \
  --set volume \
    icon.font="JetBrainsMono Nerd Font:Regular:16.0" \
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
    scroll_texts=on \
    script="$PLUGIN_DIR/volume.sh" \
  --subscribe volume volume_change mouse.scrolled mouse.clicked

# Popup slider — 10 click-to-set cells (10% .. 100%)
for level in 10 20 30 40 50 60 70 80 90 100; do
  sketchybar --add item "volume.slider.$level" popup.volume \
    --set "volume.slider.$level" \
      icon.drawing=off \
      label="$level%" \
      label.font="JetBrainsMono Nerd Font:Regular:11.0" \
      label.color="$WHITE" \
      label.padding_left=8 \
      label.padding_right=8 \
      background.color="$ITEM_BG" \
      background.height=18 \
      background.corner_radius=4 \
      padding_left=2 padding_right=2 \
      click_script="osascript -e 'set volume output volume $level' && sketchybar --set volume label=$level% --set volume popup.drawing=off"
done

sketchybar --set volume popup.horizontal=on popup.align=center
