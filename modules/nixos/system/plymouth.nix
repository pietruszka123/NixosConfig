{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemModule.plymouth;
in
{
  options = {
    systemModule.plymouth.enable = lib.mkEnableOption "enable plymouth module";
  };
  config = lib.mkIf cfg.enable {

    boot = {
      plymouth = {
        enable = true;
        theme = "rings";
        themePackages = with pkgs; [
          # By default we would install all themes
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "rings" ];
          })
        ];
      };
	  #    consoleLogLevel = 3;
	  #    initrd.verbose = false;
	  #    kernelParams = [
	  #      "quiet"
	  #      "rd.udev.log_level=3"
	  #      "rd.systemd.show_status=auto"
	  #    ];
	  #
	  #
	  # loader.timeout = 0;
    };

  };

}
