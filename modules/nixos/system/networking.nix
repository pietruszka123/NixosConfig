{ config, lib, ... }:
{
  options = {
    system.networking.enable = lib.mkEnableOption "enable pipewire module";
  };
  config = lib.mkIf config.system.networking.enable {
    networking.networkmanager.enable = true;

    networking.networkmanager.wifi.powersave = false;
  };

}
