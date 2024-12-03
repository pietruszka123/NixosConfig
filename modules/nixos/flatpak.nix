{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.flatpak;
in
{
  options = {
    modules.flatpak.enable = lib.mkEnableOption "enable flatpak module";
  };
  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;

  };

}
