{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemModule.bluetooth;
in
{
  options = {
    systemModule.bluetooth.enable = lib.mkEnableOption "enable bluetooth module";
  };
  config = lib.mkIf cfg.enable {

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    environment.systemPackages = with pkgs; [
      overskride

    ];
  };

}
