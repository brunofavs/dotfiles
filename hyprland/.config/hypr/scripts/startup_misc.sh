#!/bin/bash

# Waits for hyprpaper to start and then set the colors from the selected wallpaper. 

sleep 1 # Wait for hyprland to start. Empirical Value

monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
wallpaper=$(hyprctl hyprpaper listactive | grep -oP "(?<=${monitor}: ).*")
wal -i "$wallpaper"
