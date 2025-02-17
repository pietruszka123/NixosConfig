{
  config,
  lib,
  services,
  ...
}:
{
  options = {
    systemModule.powerManagement = {
      enable = lib.mkEnableOption "enable powerManagment module";
      termald.enable = lib.mkEnableOption {
        default = true;
        description = "enable thermald";
      };
    };
  };

  config = lib.mkIf config.systemModule.powerManagement.enable {
    powerManagement.enable = true;

    services.thermald.enable = config.system.powerManagment.termald.enable;

    services.tlp = {
      enable = true;
      settings = {
        TLP_DEFAULT_MODE = "BAT";
        TLP_PERSISTENT_DEFAULT = 1;

        USB_EXCLUDE_PHONE = 1;
      };
    };
    services.auto-cpufreq.enable = false;

  };
}
