{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.file-managers;
in
{
  options = {
    modules.file-managers.nautilus.enable = lib.mkEnableOption "enable Nautilus module";
  };
  config = {

    home.packages = lib.mkMerge [
      (lib.mkIf (cfg.nautilus.enable == true) [
        pkgs.nautilus
      ])

    ];

  };

}
