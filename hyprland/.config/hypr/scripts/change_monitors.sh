#!/bin/bash

# Path to your monitor configuration file
CONFIG_FILE="$HOME/.config/hypr/sources/monitors_auto.conf"

# List of available monitor modes (menu number → keyword in line)
declare -A OPTIONS=(
    ["1"]="Extend"
    ["2"]="Mirror"
)

# Display rofi selection menu
SELECTED=$(printf "%s\n" "${OPTIONS[@]}" | rofi -dmenu -p "Select Monitor Mode:")

# Exit if no selection was made
if [[ -z "$SELECTED" ]]; then
    echo "No option selected. Exiting."
    exit 1
fi

KEYWORD="${OPTIONS[$SELECTED]}"

# 1. Comment only lines that *start with 'monitor' and are currently active*
# sed -i '/^[[:space:]]*monitor/s/^/# /' "$CONFIG_FILE"
sed -i '/^[[:space:]]*monitor[[:space:]=]/ s/^/# /' "$CONFIG_FILE"

# 2. Uncomment the selected mode (remove leading '# ' or '#')
sed -i "/${SELECTED}/s/^[[:space:]]*#[[:space:]]*//" "$CONFIG_FILE"

# Optional: reload Hyprland (uncomment if needed)
# hyprctl reload

echo " Activated monitor profile: $SELECTED"
