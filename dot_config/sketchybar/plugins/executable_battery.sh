#!/bin/bash

BATTERY_INFO=$(pmset -g batt)
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | head -1)
CHARGING=$(echo "$BATTERY_INFO" | grep -c "AC Power")

PERCENT_NUM=${PERCENTAGE%\%}

if [ "$CHARGING" -gt 0 ]; then
  ICON="󰂄"
elif [ "$PERCENT_NUM" -ge 80 ]; then
  ICON="󰁹"
elif [ "$PERCENT_NUM" -ge 60 ]; then
  ICON="󰂁"
elif [ "$PERCENT_NUM" -ge 40 ]; then
  ICON="󰁿"
elif [ "$PERCENT_NUM" -ge 20 ]; then
  ICON="󰁽"
else
  ICON="󰂎"
fi

sketchybar --set "$NAME" \
  icon="$ICON" \
  label="$PERCENTAGE"
