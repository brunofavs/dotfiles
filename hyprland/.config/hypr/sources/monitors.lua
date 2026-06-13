---@module 'hl'

--###############
--## MONITORS ###
--###############

-- See https://wiki.hyprland.org/Configuring/Monitors/
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "2560x1440@240",
    position = "0x0",
    scale    = 1,
    vrr = 0,
})

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@120",
    position = "0x0",
    scale    = 1,
})

-- require("sources/monitors_auto")

-- monitor=HDMI-A-1,highrr,0x-1080,1,vrr,0
-- monitor=desc:Samsung Electric Company C24F390 HTQJ902227,1920x1080@60,-1920x0,1
-- monitor=desc:LG Electronics LG ULTRAGEAR 0x0000EC68,1920x1080@144,-1920x0,1

-- Random monitors
-- monitor=,preferred,-1920x0,1
-- monitor = , preferred, auto, 1, mirror, eDP-1
--
--
-- render {
--   cm_fs_passthrough = 2
--   }
