{
  config,
  lib,
  ...
}:

let
  cfg = config.systemModule.opentabletdriver;
in
{
  options = {
    systemModule.opentabletdriver.enable = lib.mkEnableOption "enable opentabletdriver module";
  };
  config = lib.mkIf cfg.enable {

    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };

}
