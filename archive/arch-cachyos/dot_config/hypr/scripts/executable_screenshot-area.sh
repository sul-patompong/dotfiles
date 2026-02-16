#!/bin/bash
# Capture selected area and open in satty for annotation

grim -g "$(slurp)" - | satty --filename - --output-filename ~/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png
