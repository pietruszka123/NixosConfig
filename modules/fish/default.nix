{ config, lib, pkgs, ... }:

let cfg = config.modules.fish;
in {
  options = { modules.fish.enable = lib.mkEnableOption "enable Fish module"; };
  config = lib.mkIf cfg.enable {

    home.file.".config/fish/config.fish".source = ./config.fish;

    #home.packages = with pkgs; [ pkgs.fishPlugins.tide ];

    # programs.fish = {
    #   enable = true;
    #   interactiveShellInit = ''
    #     set fish_greeting # Disable greeting
    #   '';
    #   plugins = [

    #     {
    #       name = "tide";
    #       src = pkgs.fishPlugins.tide;
    #     }
    #   ];

    # };
  };

}
