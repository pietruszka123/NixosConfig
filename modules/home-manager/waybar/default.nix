{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.waybar;
in
{
  options = {
    modules.waybar.enable = lib.mkEnableOption "enable waybar module";
  };
  config = lib.mkIf cfg.enable {
    home.file.".config/waybar/mocha.css".text = builtins.readFile (
      pkgs.fetchurl {
        url = "https=//github.com/catppuccin/waybar/releases/download/v1.1/mocha.css";
        hash = "sha256-llnz9uTFmEiQtbfMGSyfLb4tVspKnt9Fe5lo9GbrVpE=";
      }
    );
    home.file.".config/waybar/style.css".source = ./style.css;
    home.file.".config/waybar/config".text = builtins.toJSON {
      layer = "top"; # Waybar at top layer
      position = "top"; # Waybar position (top|bottom|left|right)
      # Choose the order of the modules
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "custom/music" ];
      modules-right = [
        "pulseaudio"
        "network"
        "bluetooth"
        "battery"
        "backlight"
        "clock"
        "tray"
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
      };
      backlight = {
        device = "intel_backlight";
        format = "{icon}";
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
      "custom/power" = lib.mkIf (config.modules.wlogout.enable == true) {
        tooltip = false;
        on-click = "wlogout &";
        format = "⏻";
      };
      # bluetooth = lib.mkIf (config.system.bluetooth.enable == true) {
      #   on-click = "overskride";
      #   format = "󰂯 {num_connections}";
      # };

    };

    home.packages = with pkgs; [
      nerd-fonts.fantasque-sans-mono
      playerctl
      waybar
    ];

  };

}
