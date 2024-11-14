{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.krita;
in
{
  options = {
    modules.krita.enable = lib.mkEnableOption "enable krita module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      krita

    ];

  };

}
