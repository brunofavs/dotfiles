#!/bin/bash

WALLPAPERS_PATH="$HOME/Pictures/Wallpapers/Minimalist"

while true; do

  NEW_WALLPAPER=$(find "$WALLPAPERS_PATH" -type f | shuf -n 1)

  hyprctl hyprpaper unload all
  hyprctl hyprpaper preload   "$NEW_WALLPAPER"
  hyprctl hyprpaper wallpaper ",$NEW_WALLPAPER"

  sleep 1200

done


