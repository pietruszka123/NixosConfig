{
  config,
  lib,
  ...
}:

let
  cfg = config.system.opentabletdriver;
in
{
  options = {
    system.opentabletdriver.enable = lib.mkEnableOption "enable opentabletdriver module";
  };
  config = lib.mkIf cfg.enable {

    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };

}
