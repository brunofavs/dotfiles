---@module 'hl'

--####################
--## LOOK AND FEEL ###
--####################

-- Refer to https://wiki.hyprland.org/Configuring/Variables/

-- https://wiki.hyprland.org/Configuring/Variables/#general
hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 6,
        border_size = 2,
        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,
        -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false,
        layout = "dwindle",
        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
    },
})

-- https://wiki.hyprland.org/Configuring/Variables/#decoration
hl.config({
    decoration = {
        rounding = 10,
        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        -- https://wiki.hyprland.org/Configuring/Variables/#blur
        blur ={
            enabled = true,
            size = 5,
            passes = 3,

        }
    },
})

hl.config({
    animations = {
        -- enabled = false,
        enabled = true,
        -- Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
    },
})

hl.animation({ leaf = "global",                enabled = true,  speed = 5,     bezier = "default" })
hl.animation({ leaf = "border",                enabled = true,  speed = 2,     bezier = "default" })
hl.animation({ leaf = "windows",               enabled = true,  speed = 6,     bezier = "default" })
hl.animation({ leaf = "workspaces",            enabled = true,  speed = 3.5,   bezier = "default" })
hl.animation({ leaf = "specialWorkspace",      enabled = true,  speed = 3.5,    bezier = "default", style = "fade" })
hl.animation({ leaf = "specialWorkspaceIn",    enabled = true,  speed = 15,    bezier = "default", style = "fade" })
hl.animation({ leaf = "specialWorkspaceOut",   enabled = true,  speed = 4,     bezier = "default", style = "fade" })

hl.config({
    group = {
        groupbar = {
            enabled = true,
            height = 10,
            font_family = "Fira Sans",
            col = {
                active = "rgba(00000024)",
                inactive = "rgba(00000012)",
                locked_active = "rgba(00000024)",
                locked_inactive = "rgba(00000012)",
            },
        },
        col = {
            border_active = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            border_inactive = "rgba(595959aa)",
        },
    },
})
