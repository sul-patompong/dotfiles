#!/bin/bash

# Display current TLP power mode for waybar

# Check if on AC or battery
if [ -f /sys/class/power_supply/AC/online ]; then
    ac_online=$(cat /sys/class/power_supply/AC/online 2>/dev/null)
else
    ac_online=$(cat /sys/class/power_supply/*/online 2>/dev/null | head -1)
fi

# Get platform profile if available
if [ -f /sys/firmware/acpi/platform_profile ]; then
    profile=$(cat /sys/firmware/acpi/platform_profile 2>/dev/null)
else
    profile="unknown"
fi

# Determine icon and text based on profile and AC status
if [ "$ac_online" = "1" ]; then
    power_source="AC"
    case "$profile" in
        "performance")
            icon="󰓅"
            text="PERF"
            class="performance"
            ;;
        "balanced")
            icon="󱐋"
            text="BAL"
            class="balanced"
            ;;
        "low-power")
            icon="󰌪"
            text="PWR"
            class="power-saver"
            ;;
        *)
            icon="󱐋"
            text="AC"
            class="balanced"
            ;;
    esac
else
    power_source="BAT"
    case "$profile" in
        "performance")
            icon="󰓅"
            text="PERF"
            class="performance"
            ;;
        "balanced")
            icon="󱐋"
            text="BAL"
            class="balanced"
            ;;
        "low-power")
            icon="󰌪"
            text="PWR"
            class="power-saver"
            ;;
        *)
            icon="󰌪"
            text="BAT"
            class="power-saver"
            ;;
    esac
fi

# Output in waybar JSON format
echo "{\"text\":\"$icon $text\",\"class\":\"$class\",\"tooltip\":\"Power: $power_source\\nProfile: $profile\\n\\nClick to change profile\"}"
