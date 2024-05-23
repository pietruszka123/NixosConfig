{ config, lib, pkgs, ... }:

let cfg = config.modules.discord;
in {
  options = {
    modules.discord.enable = lib.mkEnableOption "enable template module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      discord
      betterdiscordctl

    ];

  };

}
