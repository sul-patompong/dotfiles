#!/bin/bash

# Triggered by: sketchybar --trigger aerospace_mode_change MODE=<window|service|main>

ORANGE=0xffff8019
DARK=0xff1d2021

case "$MODE" in
  window)
    sketchybar --set "$NAME" \
      label="MOVE" \
      label.color=$DARK \
      background.color=$ORANGE \
      drawing=on
    ;;
  service)
    sketchybar --set "$NAME" \
      label="SERVICE" \
      label.color=$DARK \
      background.color=$ORANGE \
      drawing=on
    ;;
  main|*)
    sketchybar --set "$NAME" drawing=off
    ;;
esac
