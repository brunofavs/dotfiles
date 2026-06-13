---@module 'hl'

--https://wiki.hyprland.org/Useful-Utilities/Screen-Sharing/

hl.window_rule({
    name  = "windowrule-1",
    match = {
        class = "^(xwaylandvideobridge)$",
    },
    opacity = { 0.0, "override" },
    no_anim = true,
    no_initial_focus = true,
    max_size = { 1, 1 },
    no_blur = true,
})

hl.window_rule({
    name  = "windowrule-2",
    match = {
        class = "neovide",
    },
    tile = true,
})

hl.window_rule({
    name  = "windowrule-3",
    match = {
        class = "(Spotify)",
        focus = 0,
        pin = 0,
    },
    opacity = 0.7,
})

hl.window_rule({
    name  = "windowrule-4",
    match = {
        class = "(discord)",
    },
    opacity = 0.9,
})

hl.window_rule({
    name  = "windowrule-5",
    match = {
        class = "(Thunar)",
        focus = 0,
        pin = 0,
    },
    opacity = 0.7,
})

hl.window_rule({
    name  = "windowrule-6",
    match = {
        class = "(firefox)",
        focus = 0,
        pin = 0,
        fullscreen = 0,
    },
    opacity = 0.7,
})

hl.window_rule({
    name  = "windowrule-7",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

-- Prevent idling when fullscreen

hl.window_rule({
    name  = "windowrule-1",
    match = {
        class = "^(*)$",
    },
    idle_inhibit = "fullscreen",
})

hl.window_rule({
    name  = "windowrule-2",
    match = {
        title = "^(*)$",
    },
    idle_inhibit = "fullscreen",
})

hl.window_rule({
    name  = "windowrule-3",
    match = {
        fullscreen = 1,
    },
    idle_inhibit = "fullscreen",
})

-- Screensharing gist
-- https://gist.github.com/brunoanc/2dea6ddf6974ba4e5d26c3139ffb7580 


-- https://www.reddit.com/r/hyprland/comments/1eu3qdv/comment/lijb45m/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
-- Hyprshot border fix
hl.layer_rule({
    match = {
        namespace = "hyprpicker",
    },
    no_anim = true,
})

hl.layer_rule({
    match = {
        namespace = "selection",
    },
    no_anim = true,
})

