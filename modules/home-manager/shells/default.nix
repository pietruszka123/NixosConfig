{
  config,
  home,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.shells;
  shellPlugins = cfg.plugins;

in
{
  options = {
    modules.shells.plugins.tlrc.enable = lib.mkEnableOption "Enable tlrc";
    modules.shells.plugins.eza.enable = lib.mkEnableOption "Enable eza";
    modules.shells.plugins.starship.enable = lib.mkEnableOption "Enable starship";
  };

  imports = [
    ./fish
  ];
  config = {

    home.packages = lib.mkMerge [
      (lib.mkIf (shellPlugins.tlrc.enable == true) [ pkgs.tlrc ])
    ];

    programs.eza = {
      enable = shellPlugins.eza.enable;
      icons = "auto";
      enableFishIntegration = true;
      enableBashIntegration = true;
    };

    programs.starship = {
      enable = shellPlugins.starship.enable;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
  };

}
