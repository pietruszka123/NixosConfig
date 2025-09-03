{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.game_launchers.osu;
in
{
  options = {
    modules.game_launchers.osu.enable = lib.mkEnableOption "enable osu module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      osu-lazer-bin
    ];
  };

}
