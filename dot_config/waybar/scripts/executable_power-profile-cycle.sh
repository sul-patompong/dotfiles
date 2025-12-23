#!/bin/bash

# Cycle through ACPI platform profiles
# This works with TLP's PLATFORM_PROFILE settings

if [ ! -f /sys/firmware/acpi/platform_profile ]; then
    notify-send "Platform profiles not supported"
    exit 1
fi

# Get current profile
current=$(cat /sys/firmware/acpi/platform_profile)

# Get available profiles
available=$(cat /sys/firmware/acpi/platform_profile_choices)

# Cycle through profiles: low-power -> balanced -> performance -> low-power
case "$current" in
    "low-power")
        new_profile="balanced"
        ;;
    "balanced")
        new_profile="performance"
        ;;
    "performance")
        new_profile="low-power"
        ;;
    *)
        new_profile="balanced"
        ;;
esac

# Check if new profile is available
if echo "$available" | grep -q "$new_profile"; then
    echo "$new_profile" | pkexec tee /sys/firmware/acpi/platform_profile > /dev/null
    notify-send "Power Profile" "Switched to: $new_profile" -t 2000
else
    notify-send "Power Profile" "Profile $new_profile not available" -t 2000
fi
