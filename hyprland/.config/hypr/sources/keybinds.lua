
---@module 'hl'

--###################
--## KEYBINDINGSS ###
--###################

-- Sets "Windows" key as main modifier

-- -----------
-- Paper 2 Audio Test
-- -----------

-- Switch to a submap called `read`.
hl.bind("ALT" .. " + " .. "r", hl.dsp.submap("read"))

-- Start a submap called "read".
hl.define_submap("read", function()
    hl.bind("space", hl.dsp.pass({ window = "class:^(firefox)$" }))
    -- Use `reset` to go back to the global submap
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- -----------
-- Lock Screen
-- -----------
hl.bind("code:156", hl.dsp.exec_cmd("hyprlock"), { locked = true })

-- -----------------------
-- Manage External Screen
-- ------------------------
hl.bind(mainMod .. " + " .. "P", hl.dsp.exec_cmd("~/.config/hypr/scripts/change_monitors.sh"), { locked = true })

-- -----------
-- Audio
-- -----------

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("exec swayosd-client --output-volume lower"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("exec swayosd-client --output-volume raise"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("exec swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next && ~/.config/hypr/scripts/spotify_song_notification.sh"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous && ~/.config/hypr/scripts/spotify_song_notification.sh"), { locked = true })


-- -----------
-- Power (Laptop)
-- -----------
hl.bind("code:211", hl.dsp.exec_cmd("~/.config/hypr/scripts/power_profile_switcher.sh"), { locked = true })

-- -----------
-- Brightness (Laptop)
-- -----------
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s +20%"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 20%-"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 20%-"), { locked = true })
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight s +1"), { locked = true })
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight s 1-"), { locked = true })

-- https://wiki.hypr.land/Configuring/Basics/Dispatchers/#cursor
hl.bind("CTRL" .. " + " .. "XF86AudioMute", function()
                                               hl.timer(function()
                                                 hl.dispatch(hl.dsp.dpms({ action = "toggle" }))
                                               end, {timeout = 500, type = "oneshot"})
                                             end)

-- -----------
-- Walpapers
-- -----------
hl.bind(mainMod .. " + " .. "w", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper_chooser.sh >> /tmp/debug.txt"))
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. "w", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper_randomizer_on_demand.sh >> /tmp/debug.txt"))

-- -----------
-- Notifications
-- -----------
hl.bind(mainMod .. " + " .. "N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- -----------
-- Screenshots
-- -----------
hl.bind(mainMod .. " + " .. "PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("CTRL" .. " + " .. "PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

-- -----------
-- Misc
-- -----------
hl.bind(mainMod .. " + " .. "T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + " .. "C", hl.dsp.window.close())
hl.bind(mainMod .. " + " .. "M", hl.dsp.exit())
hl.bind(mainMod .. " + " .. "E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + " .. "V", hl.dsp.window.float())
hl.bind(mainMod .. " + " .. "R", hl.dsp.exec_cmd(menu))
-- bind = $mainMod, P, pseudo, # dwindle
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. "J", hl.dsp.layout("togglesplit"))

-------------
-- Windows
-------------

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + " .. "left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + " .. "right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + " .. "up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + " .. "down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + " .. "h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + " .. "l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + " .. "k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + " .. "j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "down",  hl.dsp.window.move({ direction = "down" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Maximize
-- bind = $mainMod, Z, fullscreen, 1
hl.bind(mainMod .. " + " .. "Z", hl.dsp.exec_cmd("~/.config/hypr/scripts/fullscreen.sh >> /tmp/debug.txt"))

-- Force FullScreen
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. "Z", hl.dsp.window.fullscreen({mode = "fullscreen", action = "toggle"}))
hl.bind(mainMod .. " + " .. "Z", hl.dsp.window.fullscreen({mode = "maximized", action = "toggle"}))

-------------
-- Groups
-------------
hl.bind(mainMod .. " + " .. "g", hl.dsp.group.toggle())

hl.bind(mainMod .. " + " .. "Tab", hl.dsp.group.next())
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. "Tab", hl.dsp.group.next({ forward = false }))

hl.bind(mainMod .. " + " .. "ALT" .. " + " .. "left" , hl.dsp.window.move({ direction = "left", group_aware = true }))
hl.bind(mainMod .. " + " .. "ALT" .. " + " .. "right", hl.dsp.window.move({ direction = "right", group_aware = true }))
hl.bind(mainMod .. " + " .. "ALT" .. " + " .. "up"   , hl.dsp.window.move({ direction = "up", group_aware = true }))
hl.bind(mainMod .. " + " .. "ALT" .. " + " .. "down" , hl.dsp.window.move({ direction = "down", group_aware = true }))

-------------
-- Apps
-------------

-- OBS
hl.bind("SHIFT" .. " + " .. "F10", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))

-------------
-- Plugins & Apps
-------------

hl.bind("ALT" .. " + " .. "TAB", hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"))
-- For OLED
hl.bind(mainMod .. " + " .. "SUPER_L", hl.dsp.exec_cmd("pkill waybar || waybar"), { ignore_mods = true, transparent = true, long_press = true })
-- hl.bind(mainMod .. " + " .. "SUPER_L", hl.dsp.exec_cmd("pkill waybar"), { ignore_mods = true,  transparent = true, release = true })
