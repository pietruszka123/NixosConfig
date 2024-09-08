{ config, lib, pkgs, ... }:

let cfg = config.modules.discord;
in {
  options = {
    modules.discord.enable = lib.mkEnableOption "enable template module";
  };
  config = lib.mkIf cfg.enable {

    nixpkgs.overlays = [
      (self: super: {
        discord = super.discord.overrideAttrs (_: {
          src = builtins.fetchTarball
            "https://discord.com/api/download/stable?platform=linux&format=tar.gz";
        });
      })
    ];
    home.packages = with pkgs; [
      discord
      betterdiscordctl

    ];

  };

}
