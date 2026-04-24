#!/bin/bash

STATE_FILE="/tmp/aerospace_fullscreen"

if [ -f "$STATE_FILE" ]; then
  rm "$STATE_FILE"
  sketchybar --set fullscreen_indicator drawing=off
else
  touch "$STATE_FILE"
  sketchybar --set fullscreen_indicator drawing=on
fi
