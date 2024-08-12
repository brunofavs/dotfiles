This script creates a new session each time the shortcut is pressed much like just doing "tmux" would do. It looks for sessions with the basename + counter until it finds the last one and creates a new one by incrementing 1.

````
alacritty --hold -e zsh -c ~HOME/.config/alacritty/scripts/start_tmux.sh
```` 
