{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.alvr;
in
{
  options = {
    modules.alvr.enable = lib.mkEnableOption "enable alvr module";
  };
  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      alvr
    ];

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        9943
        9944

      ];
      allowedUDPPortRanges = [

      ];
    };

  };

}
