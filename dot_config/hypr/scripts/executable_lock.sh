#!/bin/bash

# Lock screen wrapper script
# Switches keyboard layout to English before locking for easier password entry

# Switch to English layout (first layout in your configuration)
hyprctl switchxkblayout all 0

# Lock the screen
hyprlock
