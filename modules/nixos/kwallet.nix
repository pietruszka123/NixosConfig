{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.kwallet;
in
{
  options = {
    modules.kwallet.enable = lib.mkEnableOption "enable kwallet module";
  };
  config = lib.mkIf cfg.enable {

    security.pam.services.hyprland.kwallet.enable = true;

  };

}
