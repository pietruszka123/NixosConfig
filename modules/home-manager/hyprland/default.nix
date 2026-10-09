#TODO: update to new template
{
  config,
  pkgs,
  stable-pkgs,
  lib,
  userConfig,
  hyprland-source,
  split-monitor-workspaces-source,
  ...
}:
{
  options = {
    modules.hyprland.enable = lib.mkEnableOption "enable hyprland module";
    modules.hyprland.additional_config = lib.mkOption {
      default = null;
      description = "path to additional config";
    };

  };
  config = lib.mkIf config.modules.hyprland.enable {
    #programs.hyprland.enable = true;

	services.hyprpolkitagent.enable = true;

    wayland.windowManager.hyprland = {
      configType = "lua";
      plugins = [
        # split-monitor-workspaces-source.split-monitor-workspaces
      ];
      enable = true;

      package = hyprland-source.hyprland;
      portalPackage = hyprland-source.xdg-desktop-portal-hyprland;

      systemd.enable = true;
      xwayland.enable = true;
      extraConfig = builtins.readFile ./hyprland.lua;
    };
    # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    home.file.".config/hypr/app_rules.lua".source = ./app_rules.lua;
    # TODO: use specialization directly
    home.file.".config/hypr/monitor.lua" =
      if userConfig.system.specialization == "on-the-go" then
        {
          source = ./battery.lua;

        }
      else
        {
          source = ./external_monitor.lua;
        };

    home.file.".config/hypr/additional_config.lua" =
      if (config.modules.hyprland.additional_config != null) then
        {
          source = config.modules.hyprland.additional_config;
        }
      else
        {
          text = "";

        };

    home.packages = with pkgs; [
      glib

      hyprland-qtutils

      # Clipboard
      wl-clipboard
      xclip
      cliphist
      wl-clip-persist

      hyprpaper # wallpaper
      hyprsunset

      # Screenshots
      grimblast

      #    xwayland
      wayland-protocols

      xdg-utils
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      # xdg-desktop-portal-hyprland

      # hyprpolkitagent
    ];

  };

}
