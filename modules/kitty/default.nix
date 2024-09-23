{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.kitty;
in
{
  options = {
    modules.kitty.enable = lib.mkEnableOption "enable Kitty terminal module";
  };
  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ kitty ]; };

}
