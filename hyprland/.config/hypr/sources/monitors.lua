---@module 'hl'

--- WARN: Primary monitor sources are hardcoded in hypr/scripts/change_monitors.sh

--###############
--## MONITORS ###
--###############

-- See https://wiki.hyprland.org/Configuring/Monitors/

local function detect_external(primary)
    local cmd = string.format(
        "for d in /sys/class/drm/card*-*; do " ..
        "n=$(basename \"$d\" | sed 's/card[0-9]*-//'); " ..
        "s=$(cat \"$d/status\" 2>/dev/null); " ..
        "[ \"$s\" = connected ] && [ \"$n\" != '%s' ] && echo \"$n\" && break; " ..
        "done 2>/dev/null",
        primary
    )
    local f = assert(io.popen(cmd))
    local name = f:read("*l")
    f:close()
    -- condition and value_if_true or value_if_false
    return (name and name ~= "") and name or nil
end

local function apply_secondary(primary)
    local external, mode = nil, "Extend"

    local sf = io.open("/tmp/hyprland_monitor_state", "r")
    if sf then
        local state = sf:read("*l")
        sf:close()
        -- Finds 2 groups separated by a colon, where the first group is the external monitor name and the second group is the mode (Mirror or Extend)
        external, mode = state:match("^([^:]+):(.+)$")
    end

    -- Only executes detect_external if external is nil, otherwise it will use the value already assigned
    external = external or detect_external(primary)

    -- If external is still nil, it means no external monitor is connected, so we can return early without applying any configuration
    if not external then return end

    if mode == "Mirror" then
        hl.monitor({ output = external, mode = "preferred", position = "0x0",              scale = 1, mirror = primary })
    else
        hl.monitor({ output = external, mode = "preferred", position = DEFAULT_POSITION_NEW_MONITORS, scale = 1 })
    end
end

if is_desktop then
    hl.monitor({
        output   = "HDMI-A-1",
        mode     = "2560x1440@240",
        position = "0x0",
        scale    = 1,
        vrr      = 0,
    })
    -- Random monitors here
    apply_secondary("HDMI-A-1")

    -- Hard Coded monitors after
end

if is_laptop then
    hl.monitor({
        output   = "eDP-1",
        mode     = "1920x1080@120",
        position = "0x0",
        scale    = 1,
    })

    -- Random monitors here
    apply_secondary("eDP-1")

    -- Hard Coded monitors after
    hl.monitor({
        output   = "desc:LG Electronics LG ULTRAGEAR+ 410NTWG8L889",
        mode     = "2560x1440@143.99",
        position = "auto-left",
        scale    = 1,
    })
end
