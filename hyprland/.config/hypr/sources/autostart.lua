---@module 'hl'

--################
--## AUTOSTART ###
--################

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("~/.config/hypr/scripts/wallpaper_randomizer_on_demand.sh > /tmp/debug.txt")
    hl.exec_cmd("~/.config/hypr/scripts/startup_misc.sh > /tmp/debug.txt")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("swaync")
    hl.exec_cmd("systemctl --user start plasma-polkit-agent")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("snx-rs-gui")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("sleep 1 && hyprctl dispatch workspace 1")
    hl.exec_cmd("openrgb -p White")
    hl.exec_cmd("swayosd-server")
-- https://www.reddit.com/r/hyprland/comments/1fcpt30/comment/lnd9bkr/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
    hl.exec_cmd("nwg-look -a")
-- https://gist.github.com/brunoanc/2dea6ddf6974ba4e5d26c3139ffb7580
-- For xdg portal
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
-- Quickshell
    hl.exec_cmd("qs -c overview")
end)

--for libadwaita gtk4 apps you can use this command:
-- for GTK4 apps
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")

--for gtk3 apps you need to install adw-gtk3 theme (in arch linux sudo pacman -S adw-gtk-theme)
-- for GTK3 apps
hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3")

--for kde apps you need to install: sudo pacman -S qt5ct qt6ct kvantum kvantum breeze-icons
--you will need to set dark theme for qt apps from kde more difficult thans with gnome :D:
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct") -- for Qt apps# Theme


