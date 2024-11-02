#!/bin/bash

WALLPAPERS_PATH="$HOME/Pictures/Wallpapers/Minimalist"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"

# Check if WALLPAPER_PATH exists
if [ ! -d "$WALLPAPERS_PATH" ]; then
    echo "Directory $WALLPAPERS_PATH does not exist."
    exit 1
fi

while true; do

  CHOICE=$(ls "$WALLPAPERS_PATH" | grep -E ".png|.jpg" | shuf -n 1)

  NEW_WALLPAPER="$WALLPAPERS_PATH/$CHOICE"

  hyprctl hyprpaper unload all
  hyprctl hyprpaper preload   "$NEW_WALLPAPER"
  hyprctl hyprpaper wallpaper ",$NEW_WALLPAPER"

  wal -i "$NEW_WALLPAPER"

  sed -i -r "s/[^\/]*\.(jpg|png)/$CHOICE/g" "$HYPRLOCK_CONF"

  sleep 1200

done


