---@module 'hl'

-- env = AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card2

--############################
--## ENVIRONMENT VARIABLES ###
--############################

-- See https://wiki.hyprland.org/Configuring/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

--####################################
--       F*** nvidia specific        #
--####################################
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
