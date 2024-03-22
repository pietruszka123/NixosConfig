{ config, lib, services, ... }: {
  options = {
    system.powerManagement.enable =
      lib.mkEnableOption "enable powerManagment module";
  };

  config = lib.mkIf config.system.powerManagement.enable {
    powerManagement.enable = true;

    services.thermald.enable = true;

    services.tlp = {
      enable = true;
      settings = {
        TLP_DEFAULT_MODE = "BAT";
        TLP_PERSISTENT_DEFAULT = 1;

        USB_EXCLUDE_PHONE = 1;
      };
    };
    services.auto-cpufreq.enable = true;

  };
}
