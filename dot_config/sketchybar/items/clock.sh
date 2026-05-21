#!/usr/bin/env bash

sketchybar --add item clock e \
  --set clock \
    icon.drawing=off \
    label.font="JetBrainsMono Nerd Font:SemiBold:13.0" \
    label.color="$WHITE" \
    label.padding_left=12 \
    label.padding_right=12 \
    background.color="$ITEM_BG" \
    background.corner_radius=10 \
    background.height=30 \
    background.border_color="$BRACKET_BG" \
    background.border_width=1 \
    padding_left=20 padding_right=3 \
    popup.background.color="$ITEM_BG" \
    popup.background.corner_radius=8 \
    popup.background.border_color="$ACCENT" \
    popup.background.border_width=1 \
    popup.horizontal=off \
    popup.align=center \
    click_script="$PLUGIN_DIR/calendar_popup.sh" \
    script="$PLUGIN_DIR/clock.sh" \
    update_freq=30 \
  --subscribe clock mouse.clicked
