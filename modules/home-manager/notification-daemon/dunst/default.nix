{
  config,
  lib,
  pkgs,
  services,
  ...
}:

let
  cfg = config.modules.notification-daemon.dunst;
in
{
  options = {
    modules.notification-daemon.dunst.enable = lib.mkEnableOption "enable dunst module";
  };
  config = lib.mkIf cfg.enable {
    services.dunst = {
      enable = true;

      settings = {
        global = {
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          frame_color = "#8F33FFee";
          font = "Droid Sans 9";
          background = "#1B1D1E";

          # Frame
          frame_width = 2;
          corner_radius = 2;

          # Progressbar
          progress_bar_corner_radius = 2;
        };

        urgency_normal = {
          foreground = "#FFFFFF";

          #timeout = 10;
        };

      };

    };
    #home.packages = with pkgs; [ dunst ];

  };

}
