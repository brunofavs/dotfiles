#!/bin/bash

sleep 1 # Wait for hyprland to start. Empirical Value
wal -i "$(hyprctl hyprpaper listactive | grep -P "(?<=eDP-1 = ).*" -o)"
