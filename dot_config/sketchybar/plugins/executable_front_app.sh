#!/bin/bash

source "$CONFIG_DIR/helpers/icon_map_fn.sh"

APP_NAME="$INFO"
if [ -z "$APP_NAME" ]; then
  APP_NAME=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null)
fi

__icon_map "$APP_NAME"
if [ "$icon_result" = ":default:" ]; then
  # Try title-cased fallback (e.g. "ghostty" → "Ghostty")
  TITLE_CASED=$(echo "$APP_NAME" | awk '{for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1)) tolower(substr($i,2))}; print}')
  __icon_map "$TITLE_CASED"
fi

DISPLAY_NAME=$(echo "$APP_NAME" | awk '{for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1)) tolower(substr($i,2))}; print}')

sketchybar --set "$NAME" \
  icon="$icon_result" \
  label="$DISPLAY_NAME"
