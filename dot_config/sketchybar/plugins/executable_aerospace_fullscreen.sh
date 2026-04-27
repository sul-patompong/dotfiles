#!/bin/bash

# Triggered by: aerospace_fullscreen_change, front_app_switched
# Queries the focused window's fullscreen state and toggles the pill.

ORANGE=0xffff8019
DARK=0xff1d2021

IS_FS=$(aerospace list-windows --focused --format '%{window-is-fullscreen}' 2>/dev/null)

if [ "$IS_FS" = "true" ]; then
  sketchybar --set "$NAME" \
    label="FULL" \
    label.color=$DARK \
    background.color=$ORANGE \
    drawing=on
else
  sketchybar --set "$NAME" drawing=off
fi
