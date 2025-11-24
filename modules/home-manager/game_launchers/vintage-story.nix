{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.game_launchers.vintage-story;
in
{
  options = {
    modules.game_launchers.vintage-story.enable = lib.mkEnableOption "enable vintage-story module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [ vintagestory ];

  };

}
