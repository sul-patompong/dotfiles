#!/bin/bash

source "$CONFIG_DIR/icons.sh"

# media-control get → JSON like:
#   {"playing":true,"title":"Song","artist":"Artist","album":"...","bundleIdentifier":"..."}
JSON=$(media-control get 2>/dev/null)
if [ -z "$JSON" ] || [ "$JSON" = "null" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

TITLE=$(echo "$JSON"   | jq -r '.title    // empty' 2>/dev/null)
ARTIST=$(echo "$JSON"  | jq -r '.artist   // empty' 2>/dev/null)
PLAYING=$(echo "$JSON" | jq -r '.playing  // false' 2>/dev/null)

if [ -z "$TITLE" ] && [ -z "$ARTIST" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

if [ "$PLAYING" = "true" ]; then
  ICON="$ICON_PLAY"
else
  ICON="$ICON_PAUSE"
fi

if [ -n "$ARTIST" ] && [ -n "$TITLE" ]; then
  LABEL="$ARTIST — $TITLE"
elif [ -n "$TITLE" ]; then
  LABEL="$TITLE"
else
  LABEL="$ARTIST"
fi

sketchybar --set "$NAME" drawing=on icon="$ICON" label="$LABEL"
