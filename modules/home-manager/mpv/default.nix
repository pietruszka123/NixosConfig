{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.mpv;
in
{
  options = {
    modules.mpv.enable = lib.mkEnableOption "enable mpv module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [

      (mpv.override {

        scripts = with pkgs; [
          mpvScripts.mpv-osc-tethys
          mpvScripts.thumbnail
        ];

      })
    ];
    home.file.".config/mpv/mpv.conf".source = ./mpv.conf; 


  };

}
