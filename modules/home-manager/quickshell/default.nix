{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.quickshell;
in
{
  options = {
    modules.quickshell.enable = lib.mkEnableOption "enable quickshell module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [ quickshell ];
  };

}
