{ config, lib, ... }:
{
  options = {
    systemModule.networking.enable = lib.mkEnableOption "enable networking module";
  };
  config = lib.mkIf config.systemModule.networking.enable {
    networking.networkmanager.enable = true;

    networking.networkmanager.wifi.powersave = false;

    services.clamav = {
      daemon.enable = true;
      updater.enable = true;
    };
  };

}
