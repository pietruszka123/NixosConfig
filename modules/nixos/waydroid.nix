{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.waydroid;
in
{
  options = {
    modules.waydroid.enable = lib.mkEnableOption "enable waydroid module";
  };
  config = lib.mkIf cfg.enable {
    virtualisation.waydroid.enable = true;
  };

}
