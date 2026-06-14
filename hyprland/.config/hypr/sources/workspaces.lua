---@module 'hl'

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + " .. "S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. "S", hl.dsp.window.move({ workspace = "special:magic" }))

if is_desktop then
  
  hl.workspace_rule({ workspace = "1",  monitor = "HDMI-A-1" })
  hl.workspace_rule({ workspace = "2",  monitor = "HDMI-A-1" })
  hl.workspace_rule({ workspace = "3",  monitor = "HDMI-A-1" })
  hl.workspace_rule({ workspace = "4",  monitor = "HDMI-A-1", layout = "scrolling" })
  hl.workspace_rule({ workspace = "5",  monitor = "HDMI-A-1" })
  hl.workspace_rule({ workspace = "6",  monitor = "HDMI-A-1" })
  hl.workspace_rule({ workspace = "7",  monitor = "HDMI-A-1" })
  hl.workspace_rule({ workspace = "8",  monitor = "HDMI-A-1" })
  hl.workspace_rule({ workspace = "9",  monitor = "HDMI-A-1" })
  hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1" })

end

if is_laptop then
  if EXTERNAL_MONITOR_MAIN then

    hl.workspace_rule({ workspace = "1",  monitor = "HDMI-A-1" })
    hl.workspace_rule({ workspace = "2",  monitor = "HDMI-A-1" })
    hl.workspace_rule({ workspace = "3",  monitor = "HDMI-A-1" })
    hl.workspace_rule({ workspace = "4",  monitor = "HDMI-A-1", layout = "scrolling" })
    hl.workspace_rule({ workspace = "5",  monitor = "HDMI-A-1" })
    hl.workspace_rule({ workspace = "6",  monitor = "HDMI-A-1" })
    hl.workspace_rule({ workspace = "7",  monitor = "HDMI-A-1" })
    hl.workspace_rule({ workspace = "8",  monitor = "HDMI-A-1" })
    hl.workspace_rule({ workspace = "9",  monitor = "HDMI-A-1" })
    hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1" })

    hl.workspace_rule({ workspace = "11", monitor = "eDP-1" })

    -- To move workspaces to new monitor. If not changed does not do anything
    for i = 1, 10 do
      hl.dsp.workspace.move({ workspace = tostring(i), monitor = "HDMI-A-1" })
    end
    hl.dsp.workspace.move({ workspace = "11", monitor = "eDP-1" })

  else

    hl.workspace_rule({ workspace = "1",  monitor = "eDP-1" })
    hl.workspace_rule({ workspace = "2",  monitor = "eDP-1" })
    hl.workspace_rule({ workspace = "3",  monitor = "eDP-1" })
    hl.workspace_rule({ workspace = "4",  monitor = "eDP-1", layout = "scrolling" })
    hl.workspace_rule({ workspace = "5",  monitor = "eDP-1" })
    hl.workspace_rule({ workspace = "6",  monitor = "eDP-1" })
    hl.workspace_rule({ workspace = "7",  monitor = "eDP-1" })
    hl.workspace_rule({ workspace = "8",  monitor = "eDP-1" })
    hl.workspace_rule({ workspace = "9",  monitor = "eDP-1" })
    hl.workspace_rule({ workspace = "10", monitor = "eDP-1" })

    hl.workspace_rule({ workspace = "11", monitor = "HDMI-A-1" })

    for i = 1, 10 do
      hl.dsp.workspace.move({ workspace = tostring(i), monitor = "eDP-1" })
    end
    hl.dsp.workspace.move({ workspace = "11", monitor = "HDMI-A-1" })

  end

end


-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + " .. 1, hl.dsp.focus({ workspace = "1" }))
hl.bind(mainMod .. " + " .. 2, hl.dsp.focus({ workspace = "2" }))
hl.bind(mainMod .. " + " .. 3, hl.dsp.focus({ workspace = "3" }))
hl.bind(mainMod .. " + " .. 4, hl.dsp.focus({ workspace = "4" }))
hl.bind(mainMod .. " + " .. 5, hl.dsp.focus({ workspace = "5" }))
hl.bind(mainMod .. " + " .. 6, hl.dsp.focus({ workspace = "6" }))
hl.bind(mainMod .. " + " .. 7, hl.dsp.focus({ workspace = "7" }))
hl.bind(mainMod .. " + " .. 8, hl.dsp.focus({ workspace = "8" }))
hl.bind(mainMod .. " + " .. 9, hl.dsp.focus({ workspace = "9" }))
hl.bind(mainMod .. " + " .. 0, hl.dsp.focus({ workspace = "10" }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. 1, hl.dsp.window.move({ workspace = "1" }))
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. 2, hl.dsp.window.move({ workspace = "2" }))
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. 3, hl.dsp.window.move({ workspace = "3" }))
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. 4, hl.dsp.window.move({ workspace = "4" }))
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. 5, hl.dsp.window.move({ workspace = "5" }))
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. 6, hl.dsp.window.move({ workspace = "6" }))
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. 7, hl.dsp.window.move({ workspace = "7" }))
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. 8, hl.dsp.window.move({ workspace = "8" }))
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. 9, hl.dsp.window.move({ workspace = "9" }))
hl.bind("SHIFT" .. " + " .. mainMod .. " + " .. 0, hl.dsp.window.move({ workspace = "10" }))
