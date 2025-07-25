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
    modules.shells.plugins.nix-index.enable = lib.mkEnableOption {
      description = "Enable nix-index";
      default = true;
    };
  };

  imports = [
    ./fish
  ];
  config = {

    home.packages = lib.mkMerge [
      (lib.mkIf (shellPlugins.tlrc.enable == true) [ pkgs.tlrc ])
    ];

    programs.nix-index = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };

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
