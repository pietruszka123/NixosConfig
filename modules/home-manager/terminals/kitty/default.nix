{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.terminals.kitty;
in
{
  options = {
    modules.terminals.kitty.enable = lib.mkEnableOption "enable Kitty terminal module";
  };
  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ kitty ]; };

}
