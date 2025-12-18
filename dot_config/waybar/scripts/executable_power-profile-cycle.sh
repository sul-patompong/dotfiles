#!/bin/bash

# Get current power profile
current=$(powerprofilesctl get)

# Cycle through profiles
case "$current" in
    "balanced")
        powerprofilesctl set performance
        ;;
    "performance")
        powerprofilesctl set power-saver
        ;;
    "power-saver")
        powerprofilesctl set balanced
        ;;
esac
