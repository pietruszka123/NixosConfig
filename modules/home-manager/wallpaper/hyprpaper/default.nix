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
      enable = true;
      timers = {
        "timed-wallpaper" = {
          Install = {
            WantedBy = [ "timers.target" ];
          };
          Timer = {

            OnBootSec = "0s";
            OnCalendar = [
              "*-*-* 6:00:00"
              "*-*-* 19:00:00"
            ];

            Persistent = true;
            Unit = "timed-wallpaper.service";
          };
        };

      };

      services = {
        "timed-wallpaper" = {
          Service = {
            Type = "oneshot";

            ExecStart = "${pkgs.writeShellScript "update-wallpaper" ''
              	if [ $(date +"%H") -ge ${time} ]; then
              	wallpaper=$1/wallpapers/${wallpaper.evening} 
              	else
              	wallpaper=$1/wallpapers/${wallpaper.day}
              	fi
              	${pkgs.hyprland}/bin/hyprctl hyprpaper reload ,"$wallpaper"
              	''} %h";
          };
          Unit = {
            Description = "Changes wallper based on time";
          };

        };

      };
    };
    home.packages = with pkgs; [
      hyprpaper

    ];
  };

}
