{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.kdeconnect;
in
{
  options = {
    modules.kdeconnect.enable = lib.mkEnableOption "enable kdeconnect module";
  };
  config = lib.mkIf cfg.enable {
    programs.kdeconnect.enable = true;
  };

}
