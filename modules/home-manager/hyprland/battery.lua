hl.env("WLR_DRM_DEVICES", "/dev/dri/card0:/dev/dri/card1") -- card0 intel card1 nvidia

hl.monitor({ output = "eDP-1", mode = "preferred@60", position = "0x0", scale = 1.25 })
