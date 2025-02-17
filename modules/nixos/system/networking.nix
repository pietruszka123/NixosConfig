{ config, lib, ... }:
{
  options = {
    systemModule.networking.enable = lib.mkEnableOption "enable pipewire module";
  };
  config = lib.mkIf config.systemModule.networking.enable {
    networking.networkmanager.enable = true;

    networking.networkmanager.wifi.powersave = false;
  };

}
