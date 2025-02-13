#TODO: update to new template
{
  config,
  pkgs,
  stable-pkgs,
  lib,
  userConfig,
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

    #wayland.windowManager.hyprland.enable = true;

    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    home.file.".config/hypr/app_rules.conf".source = ./app_rules.conf;
    # TODO: use specialization directly
    home.file.".config/hypr/monitor.conf" =
      if userConfig.system.specialization == "on-the-go" then
        {
          source = ./battery.conf;

        }
      else
        {
          source = ./external_monitor.conf;
        };

    home.file.".config/hypr/additional_config.conf" =
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

      # Screenshots
      grimblast

      #    xwayland
      wayland-protocols

      xdg-utils
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland

      # hyprpolkitagent
    ];

  };

}
