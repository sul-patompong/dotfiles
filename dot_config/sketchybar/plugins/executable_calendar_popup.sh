#!/bin/bash

source "$CONFIG_DIR/colors.sh"

TODAY=$(date +%-d)

# Remove any prior rows (silent if absent)
for i in header week r1 r2 r3 r4 r5 r6 r7; do
  sketchybar --remove "calendar.popup.$i" >/dev/null 2>&1
done

# `cal` layout:
#   line 1: "      May 2026"
#   line 2: "Su Mo Tu We Th Fr Sa"
#   lines 3..8: day rows
HEADER=$(cal | awk 'NR==1{$1=$1; print}')
WEEK=$(cal | awk 'NR==2')

sketchybar --add item calendar.popup.header popup."$NAME" \
  --set calendar.popup.header \
    icon.drawing=off \
    label="$HEADER" \
    label.font="JetBrainsMono Nerd Font:Bold:13.0" \
    label.color="$ACCENT" \
    label.padding_left=12 label.padding_right=12 \
    background.color="$TRANSPARENT"

sketchybar --add item calendar.popup.week popup."$NAME" \
  --set calendar.popup.week \
    icon.drawing=off \
    label="$WEEK" \
    label.font="JetBrainsMono Nerd Font:Regular:12.0" \
    label.color="$GREY" \
    label.padding_left=12 label.padding_right=12 \
    background.color="$TRANSPARENT"

idx=0
while IFS= read -r line; do
  idx=$((idx + 1))
  [ -z "$line" ] && continue
  color="$WHITE"
  display="$line"
  if [[ " ${line// / } " == *" $TODAY "* ]]; then
    color="$ORANGE"
    display=$(echo "$line" | sed -E "s/(^| )$TODAY( |\$)/\1[$TODAY]\2/")
  fi
  sketchybar --add item "calendar.popup.r$idx" popup."$NAME" \
    --set "calendar.popup.r$idx" \
      icon.drawing=off \
      label="$display" \
      label.font="JetBrainsMono Nerd Font:Regular:12.0" \
      label.color="$color" \
      label.padding_left=12 label.padding_right=12 \
      background.color="$TRANSPARENT"
done < <(cal | tail -n +3)

sketchybar --set "$NAME" popup.drawing=toggle
