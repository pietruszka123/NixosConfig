{ config, pkgs, lib, ... }: {
  options = {
    modules.hyprland.enable = lib.mkEnableOption "enable hyprland module";
  };
  config = lib.mkIf config.modules.hyprland.enable {
    #programs.hyprland.enable = true;

    #wayland.windowManager.hyprland.enable = true;

    home.packages = with pkgs; [

      # Clipboard
      wl-clipboard
      cliphist
      wl-clip-persist

      hyprpaper # wallpaper

      xdg-utils
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

}
