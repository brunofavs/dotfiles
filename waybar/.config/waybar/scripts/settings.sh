#alacritty -e zsh -c "cd /home/bruno/dotfiles; nvim; pkill waybar && hyprctl dispatch exec waybar; hyprctl reload"

neovide  "${HOME}/dotfiles"; pkill waybar ; hyprctl reload

