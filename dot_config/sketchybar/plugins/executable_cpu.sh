#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# top -l 1 prints: "CPU usage: 4.16% user, 8.33% sys, 87.5% idle"
IDLE=$(top -l 1 -n 0 -F 2>/dev/null | awk -F'[,%]' '/CPU usage/ { for (i=1;i<=NF;i++) if ($i ~ /idle/) { gsub(/[^0-9.]/, "", $(i-1)); print $(i-1); exit } }')
USAGE=$(awk -v i="${IDLE:-100}" 'BEGIN { printf "%d", 100 - i }')

if   [ "$USAGE" -gt 85 ]; then COLOR="$ORANGE"
elif [ "$USAGE" -gt 60 ]; then COLOR="$ACCENT"
else                           COLOR="$WHITE"
fi

sketchybar --set "$NAME" label="${USAGE}%" label.color="$COLOR" icon.color="$COLOR"
