#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

case "$SENDER" in
  mouse.scrolled)
    DELTA=${SCROLL_DELTA:-0}
    CUR=$(osascript -e 'output volume of (get volume settings)')
    NEW=$(( CUR + (DELTA > 0 ? 5 : -5) ))
    [ "$NEW" -gt 100 ] && NEW=100
    [ "$NEW" -lt 0 ]   && NEW=0
    osascript -e "set volume output volume $NEW" 2>/dev/null
    VOL="$NEW"
    MUTED=false
    ;;
  mouse.clicked)
    if [ "$BUTTON" = "right" ]; then
      # right-click toggles mute
      MUTED_CUR=$(osascript -e 'output muted of (get volume settings)')
      if [ "$MUTED_CUR" = "true" ]; then
        osascript -e 'set volume without output muted' 2>/dev/null
      else
        osascript -e 'set volume with output muted' 2>/dev/null
      fi
    else
      sketchybar --set "$NAME" popup.drawing=toggle
    fi
    VOL=$(osascript -e 'output volume of (get volume settings)')
    MUTED=$(osascript -e 'output muted of (get volume settings)')
    ;;
  *)
    VOL="$INFO"
    [ -z "$VOL" ] && VOL=$(osascript -e 'output volume of (get volume settings)')
    MUTED=$(osascript -e 'output muted of (get volume settings)')
    ;;
esac

if [ "$MUTED" = "true" ] || [ "${VOL:-0}" -eq 0 ]; then
  ICON="$ICON_VOL_MUTE"
  COLOR="$GREY"
elif [ "$VOL" -ge 60 ]; then
  ICON="$ICON_VOL_HIGH"; COLOR="$WHITE"
elif [ "$VOL" -ge 30 ]; then
  ICON="$ICON_VOL_MED"; COLOR="$WHITE"
else
  ICON="$ICON_VOL_LOW"; COLOR="$WHITE"
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${VOL}%" label.color="$COLOR"
