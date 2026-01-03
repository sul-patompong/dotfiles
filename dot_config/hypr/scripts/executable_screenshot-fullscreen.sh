#!/bin/bash
# Capture entire screen and open in satty for annotation

grim - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png
