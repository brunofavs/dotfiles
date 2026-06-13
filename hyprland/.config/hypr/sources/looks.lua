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
        -- https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        -- col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        -- col.active_border =  rgba(51,204,255,0.933) rgba(0,255,153,0.933) 45deg
        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,
        -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false,
        layout = "dwindle",
        col = {
            active_border = { "rgba(51", 204, 255, "0.533) rgba(0", 255, 153, "0.533) 45deg" },
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
        -- blur {
        --     enabled = true
        --     size = 5
        --     passes = 2
        --     new_optimizations = yes
        --     ignore_opacity=true
        --
        -- }
    },
})

-- https://wiki.hyprland.org/Configuring/Variables/#animations
hl.config({
    animations = {
        enabled = true,
        -- Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
    },
})

hl.config({
    group = {
        -- auto_group = false
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
            border_active = { "rgba(51", 204, 255, "0.533) rgba(0", 255, 153, "0.533) 45deg" },
            border_inactive = "rgba(595959aa)",
        },
    },
})
