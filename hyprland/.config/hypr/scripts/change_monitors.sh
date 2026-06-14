#!/bin/bash

STATE_FILE="/tmp/hyprland_monitor_state"

# Determine primary monitor based on machine type
if ls /sys/class/power_supply/ 2>/dev/null | grep -qi "BAT"; then
    primary="eDP-1"
else
    primary="HDMI-A-1"
fi

# Find first connected external monitor (not primary)
external=""
for d in /sys/class/drm/card*-*; do
    name=$(basename "$d" | sed 's/card[0-9]*-//')
    status=$(cat "$d/status" 2>/dev/null)
    if [ "$status" = "connected" ] && [ "$name" != "$primary" ]; then
        external="$name"
        break
    fi
done

if [ -z "$external" ]; then
    notify-send "Monitor" "No external monitor detected"
    exit 1
fi

SELECTED=$(printf "Extend\nMirror" | rofi -dmenu -p "Monitor Mode ($external):")

[ -z "$SELECTED" ] && exit 0

echo "${external}:${SELECTED}" > "$STATE_FILE"
hyprctl reload
