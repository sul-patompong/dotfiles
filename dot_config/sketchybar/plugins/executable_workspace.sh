#!/bin/bash

WS_ID="$1"

ACCENT=0xffd79921
ORANGE=0xffff8019
GREY=0xff928374
ACTIVE_BG=0xff3c3836
TRANSPARENT=0x00000000

if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null)
fi

if [ "$WS_ID" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    icon.color=$ORANGE \
    background.color=$ACTIVE_BG
else
  sketchybar --set "$NAME" \
    icon.color=$GREY \
    background.color=$TRANSPARENT
fi
