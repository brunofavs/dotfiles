
---@module 'hl'

--##############
--## MACHINE ###
--##############

local f = io.popen("ls /sys/class/power_supply/ 2>/dev/null")
is_laptop  = f:read("*a"):match("BAT") ~= nil
is_desktop = not is_laptop
f:close()

--##################
--## MY PROGRAMS ###
--##################

mainMod = "SUPER"

terminal = "kitty"
fileManager = "thunar"
menu = "rofi -show drun -replace"

require("sources/configurations")
require("sources/autostart")
require("sources/rules")
require("sources/looks")
require("sources/input")
require("sources/keybinds")
require("sources/plugins")
require("sources/workspaces")
require("sources/monitors")
require("sources/env")
require("sources/layout")
require("sources/misc")
