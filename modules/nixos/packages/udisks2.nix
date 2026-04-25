{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.udisks2;
in
{
  options = {
    modules.udisks2.enable = lib.mkEnableOption "enable udisks2 module";
  };
  config = lib.mkIf cfg.enable {

    services.udisks2 = {
      enable = true;
    };

  };

}
