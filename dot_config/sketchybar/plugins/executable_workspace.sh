#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/helpers/icon_map_fn.sh"

WS_ID="$1"

if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null)
fi

# Apps in this workspace (unique app names, one per line)
APPS=$(aerospace list-windows --workspace "$WS_ID" --format '%{app-name}' 2>/dev/null | awk 'NF' | sort -u)
APP_COUNT=$(printf '%s\n' "$APPS" | awk 'NF' | wc -l | tr -d ' ')

# Build label = concatenated `:slug:` strings rendered by sketchybar-app-font
LABEL=""
if [ "$APP_COUNT" -gt 0 ]; then
  while IFS= read -r app; do
    [ -z "$app" ] && continue
    __icon_map "$app"
    LABEL="$LABEL$icon_result"
  done <<< "$APPS"
fi

if [ "$WS_ID" = "$FOCUSED_WORKSPACE" ]; then
  ICON_COLOR="$BAR_COLOR"
  BG_COLOR="$ACCENT"
  BORDER_COLOR="$ORANGE"
elif [ "$APP_COUNT" -gt 0 ]; then
  ICON_COLOR="$WHITE"
  BG_COLOR="$ITEM_BG"
  BORDER_COLOR="$BRACKET_BG"
else
  ICON_COLOR="$DIM"
  BG_COLOR=0x4d3c3836
  BORDER_COLOR=0x66504945
fi

if [ -n "$LABEL" ]; then
  sketchybar --animate sin_in_out 15 --set "$NAME" \
    icon.color="$ICON_COLOR" \
    background.color="$BG_COLOR" \
    background.border_color="$BORDER_COLOR" \
    label="$LABEL" \
    label.drawing=on
else
  sketchybar --animate sin_in_out 15 --set "$NAME" \
    icon.color="$ICON_COLOR" \
    background.color="$BG_COLOR" \
    background.border_color="$BORDER_COLOR" \
    label="" \
    label.drawing=off
fi
