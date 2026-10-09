hl.on("hyprland.start", function()
    hl.exec_cmd(
        "push-to-talk -k BTN_EXTRA -n MOUSE9 /dev/input/by-id/usb-SteelSeries_SteelSeries_Rival_650_Wireless_000000000000-if01-event-mouse")
    hl.exec_cmd("xrandr --output DP-1 --primary")
    hl.exec_cmd("noctalia-shell")
end)

-- bind = , mouse:276, pass, class:^(discord)$  -- Pass MOUSE5 to TeamSpeak3.


hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-1", mode = "2560x1440@180", position = "1920x0", scale = 1 })

-- xwayland { force_zero_scaling = true }
-- package.path = package.path .. ";/path/to/split-monitor-workspaces/lua/?.lua"

--- Import the library.
local smw = require("./plugins/split-monitor-workspaces")
smw.setup({
    max_workspaces = { ["HDMI-A-1"] = 5 }
})
