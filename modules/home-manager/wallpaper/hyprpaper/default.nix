{
  config,
  lib,
  pkgs,
  wallpaper,
  ...
}:

let
  cfg = config.modules.wallpaper;
  time = wallpaper.time;
in
{
  options = {
    modules.wallpaper.hyprpaper = lib.mkEnableOption "enable hyprpaper module";
  };
  config = lib.mkIf cfg.enable {

    home.file = {
      ".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    };

    systemd.user = {
      timers = {
        "timed-wallpaper" = {

        };

      };

      services = {
        "timed-wallpaper" = {
          Service = {
            ExecStart = "${pkgs.writeShellScript "update-wallpaper" ''
              	if [ $(date +"%H") -ge ${time} ]; then
              	wallpaper=${wallpaper.evening} 
              	else
              	wallpaper=${wallpaper.day}
              	fi
              	${pkgs.hyprland}/bin/hyprctl hyprpaper reload ,"$wallpaper"
              	''}";
          };
          Unit = {
            Description = "Changes wallper based on time";
          };

          serviceConfig = {
            Type = "oneshot";

          };

        };

      };
    };
    home.packages = with pkgs; [
      hyprpaper

    ];
  };

}
