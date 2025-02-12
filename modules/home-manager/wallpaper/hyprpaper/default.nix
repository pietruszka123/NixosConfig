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

    # systemd.user = {
    #   services = {
    #     "timed-wallpaper" = {
    #       script = [
    #         ''
    #           	if [ $(date +"%H") -ge ${time} ]; then
    #           	wallpaper=${wallpaper.evening} 
    #           	else
    #           	wallpaper=${wallpaper.day}
    #           	fi
    #           	${pkgs.hyprland}/bin/hyprctl hyprpaper reload ,"$wallpaper.evening"
    #           	''
    #       ];
    #
    #       Unit = {
    #         Description = "Changes wallper based on time";
    #       };
    #
    #       serviceConfig = {
    #         Type = "oneshot";
    #
    #       };
    #
    #     };
    #
    #   };
    #   timers = { };
    # };
    home.packages = with pkgs; [
      hyprpaper
      

    ];
  };

}
