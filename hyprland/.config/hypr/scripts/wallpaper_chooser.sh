#!/bin/bash

WALLPAPERS_PATH="$HOME/Pictures/Wallpapers/Minimalist"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"

# Check if WALLPAPER_PATH exists
if [ ! -d "$WALLPAPERS_PATH" ]; then
    echo "Directory $WALLPAPERS_PATH does not exist."
    exit 1
fi

# Get a list of files in WALLPAPER_PATH and display them in a rofi menu
CHOICE=$(ls "$WALLPAPERS_PATH" | grep -E ".png|.jpg" | rofi -dmenu -i -p "Select a wallpaper:")

# Exit if no choice was made
if [ -z "$CHOICE" ]; then
    echo "No wallpaper selected."
    exit 1
fi

SELECTED_WALLPAPER="$WALLPAPERS_PATH/$CHOICE"

echo "Wallpaper set to: $SELECTED_WALLPAPER"

hyprctl hyprpaper unload all
hyprctl hyprpaper preload   "$SELECTED_WALLPAPER"
hyprctl hyprpaper wallpaper ",$SELECTED_WALLPAPER"

sed -i -r "s/[^\/]*\.(jpg|png)/$CHOICE/g" "$HYPRLOCK_CONF"

