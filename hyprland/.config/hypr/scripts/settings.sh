alacritty -e zsh -c "cd /home/bruno/.config/hypr/; nvim; pkill waybar && hyprctl dispatch exec waybar; hyprctl reload"
