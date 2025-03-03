{
  config,
  home,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.shells;

in
{
  options = {
    modules.shells.tlrc.enable = lib.mkEnableOption "Enable tlrc";
    modules.shells.eza.enable = lib.mkEnableOption "Enable eza";
  };

  imports = [
    ./fish
  ];
  config = {

    home.packages = lib.mkMerge [
      (lib.mkIf (cfg.tlrc.enable == true) [ pkgs.tlrc ])
    ];

    programs.eza = {
      enable = cfg.eza.enable;
      enableFishIntegration = cfg.fish.enable;
      enableBashIntegration = true;

    };
  };

}
