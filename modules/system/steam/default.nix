{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.steam;
in
{
  options = {
    modules.steam.enable = lib.mkEnableOption "enable steam module";
  };
  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;

  };

}
