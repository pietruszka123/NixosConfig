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
      "battery"
      "backlight"
      "clock"
      "tray"
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
      on-click = "sh -c '(sleep 0.5s; swaylock --grace 0)' & disown";
      format = "";
    };
    "custom/power" = {
      tooltip = false;
      on-click = "wlogout &";
      format = "⏻";
    };
    bluetooth = {
      on-click = "overskride";
      format = "󰂯 {num_connections}";
    };

  };

  #TODO: change it to remove disabled modules
  merge =
    config: modules:
    let
      f = f: s: f // { modules-right = (f.modules-right ++ s); };
    in
    lib.lists.foldl f config modules;

  makeConf =
    c:
    let
      wlogout = if (config.modules.wlogout.enable == true) then [ "custom/power" ] else [ ];
      bluetooth = if (systemConfig.systemModule.bluetooth.enable == true) then [ "bluetooth" ] else [ ];
    in
    merge conf [
      wlogout
      bluetooth
    ];
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
      playerctl
      waybar
    ];

  };

}
