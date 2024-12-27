{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.prism-launcher;
in
{
  options = {
    modules.prism-launcher.enable = lib.mkEnableOption "enable prism-launcher module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [

      (prismlauncher.override {
        # Change Java runtimes available to Prism Launcher
        jdks = [
          graalvm-ce
          zulu17
	  zulu8
        ];
      })

    ];

  };

}
