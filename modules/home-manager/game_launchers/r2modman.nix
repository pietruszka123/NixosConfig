{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.game_launchers.r2modman;
in
{
  options = {
    modules.game_launchers.r2modman.enable = lib.mkEnableOption "enable r2modman module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      r2modman
    ];

  };

}
