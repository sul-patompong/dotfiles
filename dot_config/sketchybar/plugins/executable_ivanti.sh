#!/bin/sh

# Check Ivanti connection status
# This script checks if Ivanti services are running and accessible

CIRCLE_ICON="●"
LABEL_TEXT="Ivanti"

# Check if Ivanti processes are running
IVANTI_PROCESSES=$(ps aux | grep -i ivanti | grep -v grep | wc -l)

# Check if Ivanti VPN interface is active
# Look for VPN interface with 192.168.72.x IP range (common for Ivanti)
IVANTI_NETWORK_CHECK=$(ifconfig | grep "inet 192\.168\.72\." > /dev/null 2>&1 && echo "connected" || echo "disconnected")

if [ "$IVANTI_PROCESSES" -gt 0 ]; then
    if [ "$IVANTI_NETWORK_CHECK" = "connected" ]; then
        CIRCLE_COLOR="0xff00ff00"  # Green for connected
    else
        CIRCLE_COLOR="0xffff0000"  # Red for disconnected
    fi
else
    CIRCLE_COLOR="0xffffffff"  # White for not running
fi

# Update the SketchyBar item
sketchybar --set "$NAME" icon="$CIRCLE_ICON" label="$LABEL_TEXT" icon.color="$CIRCLE_COLOR" label.color="0xffffffff"