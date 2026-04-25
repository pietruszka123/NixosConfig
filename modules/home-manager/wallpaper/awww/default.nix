{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.wallpaper.awww;
in
{
  options = {
    modules.wallpaper.awww.enable = lib.mkEnableOption "enable awww module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      swww
    ];
  };

}
