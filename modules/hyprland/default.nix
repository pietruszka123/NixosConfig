{ config, pkgs, lib, userConfig, ... }: {
  options = {
    modules.hyprland.enable = lib.mkEnableOption "enable hyprland module";
  };
  config = lib.mkIf config.modules.hyprland.enable {
    #programs.hyprland.enable = true;

    #wayland.windowManager.hyprland.enable = true;

    	home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    # TODO: use specialization directly
    home.file.".config/hypr/monitor.conf" =
      if userConfig.system.specialization == "on-the-go" then {
source = ./battery.conf;

      } else {
                source = ./external_monitor.conf;      };

    home.packages = with pkgs; [
      glib

      # Clipboard
      wl-clipboard
      cliphist
      wl-clip-persist

      hyprpaper # wallpaper

# Screenshots
      grim
      slurp



      xdg-utils
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

}
