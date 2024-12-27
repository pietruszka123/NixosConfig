{
  config,
  lib,
  pkgs,
  home,
  ...
}:

let
  cfg = config.modules.wine;
in
{
  options = {
    modules.wine.enable = lib.mkEnableOption "enable wine module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      #      wineWowPackages.waylandFull
      wineWowPackages.stable
      winetricks
    ];

  };

}
