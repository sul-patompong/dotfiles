#!/bin/bash

LAYOUT=$("$HOME/.local/bin/keyboard-layout" 2>/dev/null)

case "$LAYOUT" in
  *Thai*) LABEL="TH" ;;
  *)      LABEL="EN" ;;
esac

sketchybar --set "$NAME" label="$LABEL"
