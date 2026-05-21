#!/usr/bin/env bash
# AeroSpace mode pill, fullscreen pill, and workspace indicators.

sketchybar --add event aerospace_mode_change
sketchybar --add event aerospace_fullscreen_change
sketchybar --add event aerospace_workspace_change

# Mode pill (MOVE / SERVICE)
sketchybar --add item aerospace_mode left \
  --set aerospace_mode \
    icon.drawing=off \
    label.font="JetBrainsMono Nerd Font:Bold:14.0" \
    label.padding_left=8 \
    label.padding_right=8 \
    background.color="$ORANGE" \
    background.corner_radius=6 \
    background.height=22 \
    drawing=off \
    script="$PLUGIN_DIR/aerospace_mode.sh" \
  --subscribe aerospace_mode aerospace_mode_change

# Fullscreen pill (FULL)
sketchybar --add item aerospace_fullscreen left \
  --set aerospace_fullscreen \
    icon.drawing=off \
    label.font="JetBrainsMono Nerd Font:Bold:14.0" \
    label.padding_left=8 \
    label.padding_right=8 \
    background.color="$ORANGE" \
    background.corner_radius=6 \
    background.height=22 \
    drawing=off \
    script="$PLUGIN_DIR/aerospace_fullscreen.sh" \
  --subscribe aerospace_fullscreen aerospace_fullscreen_change front_app_switched

# Workspaces — icon is the workspace key, label = brand glyphs of apps living there
WORKSPACES=("u" "i" "o" "p" "7" "8" "9" "0")
WS_LABELS=("U" "I" "O" "P" "7" "8" "9" "0")

for i in "${!WORKSPACES[@]}"; do
  ws="${WORKSPACES[$i]}"
  key="${WS_LABELS[$i]}"
  sketchybar --add item "workspace.$ws" left \
    --set "workspace.$ws" \
      icon="$key" \
      icon.font="JetBrainsMono Nerd Font:Bold:14.0" \
      icon.color="$DIM" \
      icon.padding_left=10 \
      icon.padding_right=6 \
      label.drawing=off \
      label.font="sketchybar-app-font:Regular:18.0" \
      label.color="$WHITE" \
      label.padding_left=2 \
      label.padding_right=10 \
      label.y_offset=-1 \
      background.color="$ITEM_BG" \
      background.corner_radius=10 \
      background.height=30 \
      background.border_color="$BRACKET_BG" \
      background.border_width=1 \
      padding_left=3 \
      padding_right=3 \
      click_script="aerospace workspace $ws" \
      script="$PLUGIN_DIR/workspace.sh $ws" \
    --subscribe "workspace.$ws" aerospace_workspace_change front_app_switched
done

# (No bracket — each workspace gets its own pill bg)
