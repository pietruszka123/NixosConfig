{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.syncthing;
in
{
  options = {
    modules.syncthing.enable = lib.mkEnableOption "enable syncthing module";
  };
  config = lib.mkIf cfg.enable {

    services.syncthing = {
      enable = true;
    };

  };

}
