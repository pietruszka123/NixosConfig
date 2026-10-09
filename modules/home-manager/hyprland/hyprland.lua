require("monitor")
require("additional_config")
require("app_rules")


-- package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("./plugins.split-monitor-workspaces")


hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})
hl.env("MUTTER_DEBUG_KMS_THREAD_TYPE", "user")

-- -- Screensharing fix
-- windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
-- windowrulev2 = noanim,class:^(xwaylandvideobridge)$
-- windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$
-- windowrulev2 = maxsize 1 1,class:^(xwaylandvideobridge)$
-- windowrulev2 = noblur,class:^(xwaylandvideobridge)$

--windowrulev2 = immediate, class:^(Loading...)$

--windowrulev2 = plugin:hyprbars:nobar, class:.*


-- windowrulev2 =noblur, class:^(?!Alacritty).*

smw.setup({
    workspace_count = 10,
    keep_focused = true,
    enable_notifications = false,
    enable_persistent_workspaces = false,
    link_monitors = false
})


-- debug:disable_logs = false

hl.config({

    -- For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input = {
        kb_layout = "pl",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1
        ,
        touchpad = {
            natural_scroll = true
            ,
            scroll_factor = 0.8
        }
        ,
        sensitivity = -0.5 -- -1.0 - 1.0, 0 means no modification.
    },

    -- unscale XWayland
    -- xwayland {
    --   force_zero_scaling = true
    -- }

    -- toolkit-specific scale
    -- env = GDK_SCALE,2

    general = {
        gaps_in = 1,
        gaps_out = 2, --5
        border_size = 2,
        --col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col = {
            active_border = { colors = { "rgba(8F33FFee)", "rgba(FF00FBee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)"
        },
        layout = "dwindle",
        allow_tearing = true
    },

    decoration = {
        rounding = 10,
        blur = {
            enabled = false, -- change for battery
            size = 3,
            passes = 1,
        },
        shadow = {
            enabled = false
        }

    },

    animations = {
        enabled = true,

    },

    dwindle = {
        preserve_split = true -- you probably want this
    },

    master = {

        --new_is_master = true
    },

    gestures = {
        workspace_swipe_cancel_ratio = 0.3,

    },
    misc = {
        force_default_wallpaper = 0 -- Set to 0 to disable the anime mascot wallpapers
        ,
        disable_hyprland_logo = true
        ,
        disable_splash_rendering = true
        ,
        middle_click_paste = false
    }
})


hl.gesture({
    fingers = 4,
    direction = "horizontal",
    action = "workspace"
})
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })


-- See https://wiki.hyprland.org/Configuring/Keywords/ for more
local mainMod = "SUPER"

-- Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
hl.bind(mainMod .. "+Q", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. "+F", hl.dsp.exec_cmd("firefox"))


hl.bind(mainMod .. "+N", hl.dsp.exec_cmd("swaync-client -t -sw"))

hl.bind(mainMod .. "+C", hl.dsp.window.close())
hl.bind(mainMod .. "+M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. "+E", hl.dsp.exec_cmd("nautilus ~ -w"))
hl.bind(mainMod .. "+V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. "+R", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(mainMod .. "+P", hl.dsp.window.pseudo())       -- dwindle
hl.bind(mainMod .. "+J", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. "+ SHIFT +F", hl.dsp.window.fullscreen())   -- fullscreen

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. "+ left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. "+ right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. "+ up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. "+ down", hl.dsp.focus({ direction = "down" }))

-- Move window with mainMod + SHIFT + arrow keys
hl.bind(mainMod .. "+ SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. "+ SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. "+ SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. "+ SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. "+ 1", smw.workspace("1"))
hl.bind(mainMod .. "+ 2", smw.workspace("2"))
hl.bind(mainMod .. "+ 3", smw.workspace("3"))
hl.bind(mainMod .. "+ 4", smw.workspace("4"))
hl.bind(mainMod .. "+ 5", smw.workspace("5"))
hl.bind(mainMod .. "+ 6", smw.workspace("6"))
hl.bind(mainMod .. "+ 7", smw.workspace("7"))
hl.bind(mainMod .. "+ 8", smw.workspace("8"))
hl.bind(mainMod .. "+ 9", smw.workspace("9"))
hl.bind(mainMod .. "+ 0", smw.workspace("10"))

-- Workspace 2
hl.bind(mainMod .. " + KP_End", hl.dsp.focus({ workspace = 91 }))
hl.bind(mainMod .. "+ KP_Down", hl.dsp.focus({ workspace = 92 }))
hl.bind(mainMod .. "+ KP_Next", hl.dsp.focus({ workspace = 93 }))
hl.bind(mainMod .. "+ KP_Left", hl.dsp.workspace.toggle_special("special2"))
hl.bind(mainMod .. "+ KP_Begin", hl.dsp.workspace.toggle_special("special3"))

-- bind = $mainMod, KP_Begin, movetoworkspace, 5
-- bind = $mainMod, KP_Right, movetoworkspace, 6
-- bind = $mainMod, KP_Home, movetoworkspace, 7
-- bind = $mainMod, KP_Up, movetoworkspace, 8
-- bind = $mainMod, KP_Prior, movetoworkspace, 9
-- bind = $mainMod, KP_Insert, movetoworkspace, 10


-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. "+ SHIFT + " .. key, smw.move_to_workspace(tostring(i)))
end

-- Move 2
hl.bind(mainMod .. "+ SHIFT + KP_End", hl.dsp.window.move({ workspace = 91 }))
hl.bind(mainMod .. "+ SHIFT + KP_Down", hl.dsp.window.move({ workspace = 92 }))
hl.bind(mainMod .. "+ SHIFT + KP_Next", hl.dsp.window.move({ workspace = 93 }))
hl.bind(mainMod .. "+ SHIFT + KP_Left", hl.dsp.window.move({ workspace = "special:special2" }))
hl.bind(mainMod .. "+ SHIFT + KP_Begin", hl.dsp.window.move({ workspace = "special:special3" }))


-- Example special workspace (scratchpad)
hl.bind(mainMod .. "+ S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. "+ SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", smw.cycle_workspaces("next"))
hl.bind(mainMod .. " + mouse_up", smw.cycle_workspaces("prev"))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd("grimblast --freeze save area - | wl-copy"))

-- Clipboard
hl.bind(mainMod .. "+ D",
    hl.dsp.exec_cmd(
        "vicinae vicinae://extensions/vicinae/clipboard/history --cliphist list | tofi | cliphist decode | wl-copy"))

--exec-once = wl-paste -t text -w xclip -selection clipboard --wine clipboard fix

-- Pin Window
-- bind = $mainMod, O, pin




--Cursor Theme
hl.env("XCURSOR_SIZE", "21")
hl.env("HYPRCURSOR_SIZE", "21")
--hl.env("HYPRCURSOR_THEME", "catppuccin-Mocha-Lavender-Cursors")
hl.env("XCURSOR_THEME", "catppuccin-mocha-lavender")



-- Workspaces
hl.workspace_rule({ workspace = "special:magic", gaps_out = 32 })


hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl setcursor $XCURSOR_THEME $HYPRCURSOR_SIZE")
    --Wallpaper
    hl.exec_cmd("hyprpaper")
    -- Clipboard
    hl.exec_cmd("wl-paste --type text --watch cliphist store --Stores only text data")
    hl.exec_cmd("wl-paste --type image --watch cliphist store --Stores only image data")
    -- Waybar
    hl.exec_cmd("waybar")


    -- Authentication Agent
    -- exec-once = systemctl --user start hyprpolkitagent
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
end)
