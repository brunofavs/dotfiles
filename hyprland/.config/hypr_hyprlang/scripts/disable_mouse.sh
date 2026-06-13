#!/bin/bash
# To use with screen DPMS on demand. If screen turns off naturally, I can wake it up with the bind and it does not deactive my mouse.

DEVICE_NAME="razer-razer-deathadder-essential"
STATE_FILE="/tmp/hypr_device_${DEVICE_NAME}_enabled"

# Get DPMS status: 1 = screen ON, 0 = screen OFF
get_dpms_status() {
    hyprctl monitors | grep 'dpmsStatus:' | awk '{print $2}'
}

# Ensure state file exists
[[ ! -f "$STATE_FILE" ]] && echo "enabled" > "$STATE_FILE"

CURRENT_STATE=$(cat "$STATE_FILE")
DPMS_STATUS=$(get_dpms_status)

# Logic
if [[ "$DPMS_STATUS" == "1" ]]; then
    # Screen is ON: toggle the mouse
    if [[ "$CURRENT_STATE" == "enabled" ]]; then
        echo "Disabling $DEVICE_NAME..."
        hyprctl keyword "device[${DEVICE_NAME}]:enabled" false
        echo "disabled" > "$STATE_FILE"
    else
        echo "Enabling $DEVICE_NAME..."
        hyprctl keyword "device[${DEVICE_NAME}]:enabled" true
        echo "enabled" > "$STATE_FILE"
    fi
else
    # Screen is OFF: only allow enabling the mouse
    if [[ "$CURRENT_STATE" == "disabled" ]]; then
        echo "Screen is off but mouse is disabled — re-enabling $DEVICE_NAME..."
        hyprctl keyword "device[${DEVICE_NAME}]:enabled" true
        echo "enabled" > "$STATE_FILE"
    else
        echo "Screen is off and mouse is already enabled — doing nothing."
    fi
fi
