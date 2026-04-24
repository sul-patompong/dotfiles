#!/bin/bash

# Usage: border_color.sh <mode>
# Changes the window border color to indicate aerospace mode.

MODE="$1"
DEFAULT="gradient(top_left=0xffff8019,bottom_right=0xfffabd2f)"
WINDOW="0xffd79921"

case "$MODE" in
  window)
    borders active_color="$WINDOW"
    ;;
  main)
    borders active_color="$DEFAULT"
    ;;
esac
