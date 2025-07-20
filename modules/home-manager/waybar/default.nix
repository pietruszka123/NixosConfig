{
  config,
  lib,
  pkgs,
  systemConfig,
  ...
}:

let
  cfg = config.modules.waybar;
  jsonFormat = pkgs.formats.json { };

  conf = {
    layer = "top"; # Waybar at top layer
    position = "top"; # Waybar position (top|bottom|left|right)
    # Choose the order of the modules
    modules-left = [ "hyprland/workspaces" ];
    #modules-center = [ "custom/music" ];
    modules-right = [
      "pulseaudio"
      "network"
      "bluetooth"
      "custom/notification"
      "battery"
      "backlight"
      "clock"
      "tray"
      "custom/lock"
      "custom/power"
    ];
    "hyprland/workspaces" = {
      disable-scroll = true;
      sort-by-name = true;
      format = " {icon} ";
      format-icons = {
        default = "";
      };
    };
    tray = {
      icon-size = 21;
      spacing = 10;
    };
    "custom/music" = {
      format = "  {}";
      escape = true;
      interval = 5;
      tooltip = false;
      exec = "playerctl metadata --format='{{ title }}'";
      on-click = "playerctl play-pause";
      max-length = 50;
    };
    network = {
      format-wifi = "  {signalStrength}%";
      format-ethernet = "󰕒 {bandwidthUpBytes} 󰇚 {bandwidthDownBytes}  ";
      format-linked = "󰅛";
      format-disconnected = "⚠";
      format-alt = "{ipaddr}/{cidr}";
    };
    clock = {
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "󰃭 {:%d/%m/%Y}";
      format = "  {:%H:%M}";
      calendar = {
        mode = "year";
        mode-mon-col = 3;
        weeks-pos = "right";
        on-scroll = 1;
        format = {
          "months" = "<span color='#ffead3'><b>{}</b></span>";
          "days" = "<span color='#ecc6d9'><b>{}</b></span>";
          "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
          "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
          "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
        };
      };
    };
    backlight = {
      device = "intel_backlight";
      format = "{icon}";
      tooltip-format = "{percent}%";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
      ];
    };
    battery = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon}";
      format-charging = "󰂄";
      format-plugged = "";
      tooltip-format = "{capacity}% {time}";
      format-alt = "{icon}";
      format-icons = [
        "󰂃"
        "󰁺"
        "󰁻"
        "󰁼"
        "󰁽"
        "󰁾"
        "󰁾"
        "󰁿"
        "󰂀"
        "󰂁"
        "󰂁"
        "󰁹"
      ];

    };
    pulseaudio = {
      # scroll-step= 1; # %, can be a float
      format = "{icon}  {volume}%";
      format-muted = "";
      format-icons = {
        default = [
          ""
          ""
          " "
        ];
      };
      on-click = "pavucontrol";
    };
    "custom/lock" = {
      tooltip = false;
      on-click = "sh -c '(sleep 0.5s; hyprlock --immediate)' & disown";
      format = "";
    };
    "custom/power" = {
      tooltip = false;
      on-click = "wlogout &";
      format = "⏻";
    };
    bluetooth = {
      on-click = "overskride";
      format-off = "󰂲";
      format-on = "󰂯";
      format-connected = "󰂱 {num_connections}";
      format = "󰂯 {num_connections}";
      tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
    };
    "custom/notification" = {
      "tooltip" = false;
      "format" = "{icon}";
      "format-icons" = {
        "notification" = "<span foreground='red'><sup></sup></span>";
        "none" = "";
        "dnd-notification" = "<span foreground='red'><sup></sup></span>";
        "dnd-none" = "";
        "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
        "inhibited-none" = "";
        "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
        "dnd-inhibited-none" = "";
      };
      "return-type" = "json";
      "exec-if" = "which swaync-client";
      "exec" = "swaync-client -swb";
      "on-click" = "swaync-client -t -sw";
      "on-click-right" = "swaync-client -d -sw";
      "escape" = true;
    };
  };

  deleteValue =
    arr: modules:
    let
      filter = v: ((!builtins.hasAttr v modules) || (builtins.getAttr v modules == true));
    in
    lib.lists.filter filter arr;
  makeConf =
    c:
    let
      right = {
        "custom/power" = config.modules.wlogout.enable;
        "custom/lock" = config.modules.hyprlock.enable;
        "bluetooth" = systemConfig.systemModule.bluetooth.enable;
      };
    in
    c
    // {
      "modules-right" = (deleteValue c.modules-right right);
    };
  finalConf = makeConf conf;

in
{
  options = {
    modules.waybar.enable = lib.mkEnableOption "enable waybar module";
  };
  config = lib.mkIf cfg.enable {
    home.file.".config/waybar/mocha.css".text = builtins.readFile (
      pkgs.fetchurl {
        url = "https://github.com/catppuccin/waybar/releases/download/v1.1/mocha.css";
        hash = "sha256-llnz9uTFmEiQtbfMGSyfLb4tVspKnt9Fe5lo9GbrVpE=";
      }
    );

    # conf.modules-right = lib.mkIf (config.modules.wlogout.enable == true) [ "custom/power" ];

    home.file.".config/waybar/style.css".source = ./style.css;

    home.file.".config/waybar/config" = {
      source = jsonFormat.generate "waybar-config" (finalConf);
      onChange = ''
        ${pkgs.procps}/bin/pkill -u $USER -USR2 waybar || true
      '';

    };
    home.packages = with pkgs; [
      nerd-fonts.fantasque-sans-mono
      # playerctl
      waybar
    ];

  };

}
