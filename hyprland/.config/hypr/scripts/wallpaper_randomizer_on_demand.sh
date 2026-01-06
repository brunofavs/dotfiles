#!/bin/bash

echo "Wallpaper randomizer started"

WALLPAPERS_PATH="$HOME/Pictures/Wallpapers/Minimalist"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"

# Check if WALLPAPER_PATH exists
if [ ! -d "$WALLPAPERS_PATH" ]; then
    echo "Directory $WALLPAPERS_PATH does not exist."
    exit 1
fi

# Check if hyprpaper is running, start it if not
if ! pgrep -x hyprpaper > /dev/null; then
    echo "hyprpaper not running, starting it..."
    hyprpaper &
    while ! pgrep -x hyprpaper > /dev/null; do
        sleep 0.1
    done
    echo "hyprpaper started successfully"
fi



CHOICE=$(ls "$WALLPAPERS_PATH" | grep -E ".png|.jpg|.jpeg" | shuf -n 1)

NEW_WALLPAPER="$WALLPAPERS_PATH/$CHOICE"

# hyprctl hyprpaper unload all
# hyprctl hyprpaper preload   "$NEW_WALLPAPER"
# hyprctl hyprpaper wallpaper ",$NEW_WALLPAPER"

end_time=$((SECONDS + 5))
while [ $SECONDS -lt $end_time ]; do

    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$NEW_WALLPAPER"
    output=$(hyprctl hyprpaper wallpaper ",$NEW_WALLPAPER" 2>&1)
    
    echo "$output" | grep "running" > /dev/null
    if [ $? -eq 1 ]; then
        break
    fi
    sleep 0.1
done

wal -i "$NEW_WALLPAPER"

sed -i -r "s/[^\/]*\.(jpg|png|jpeg)/$CHOICE/g" "$HYPRLOCK_CONF"


