#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

BATT_INFO=$(pmset -g batt)
PERCENT=$(echo "$BATT_INFO" | grep -Eo '\d+%' | head -1)
PCT_NUM=${PERCENT%\%}
CHARGING=$(echo "$BATT_INFO" | grep -c "AC Power")
TIME_LEFT=$(echo "$BATT_INFO" | sed -nE 's/.*([0-9]+:[0-9]+) remaining.*/\1/p')
[ -z "$TIME_LEFT" ] && TIME_LEFT="—"
CYCLES=$(system_profiler SPPowerDataType 2>/dev/null | awk -F': ' '/Cycle Count/ {print $2; exit}')
[ -z "$CYCLES" ] && CYCLES="?"

if [ "$CHARGING" -gt 0 ]; then
  ICON="$ICON_BATT_CHARGING"
  COLOR="$ACCENT"
  STATUS="Charging"
elif [ "$PCT_NUM" -lt 20 ]; then
  ICON="$ICON_BATT_LOW"
  COLOR="$ORANGE"
  STATUS="Discharging (low)"
elif [ "$PCT_NUM" -ge 80 ]; then
  ICON="$ICON_BATT_100"; COLOR="$WHITE"; STATUS="On battery"
elif [ "$PCT_NUM" -ge 60 ]; then
  ICON="$ICON_BATT_75"; COLOR="$WHITE"; STATUS="On battery"
elif [ "$PCT_NUM" -ge 40 ]; then
  ICON="$ICON_BATT_50"; COLOR="$WHITE"; STATUS="On battery"
else
  ICON="$ICON_BATT_25"; COLOR="$WHITE"; STATUS="On battery"
fi

sketchybar --animate sin_in_out 20 --set "$NAME" \
  icon="$ICON" \
  icon.color="$COLOR" \
  label="$PERCENT" \
  label.color="$COLOR"

sketchybar --set battery.popup.status label="Status: $STATUS" \
           --set battery.popup.time   label="Time:   $TIME_LEFT" \
           --set battery.popup.cycles label="Cycles: $CYCLES"
