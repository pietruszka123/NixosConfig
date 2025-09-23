{
  config,
  lib,
  pkgs,
  stable-pkgs,
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

    # programs.alvr = {
    #   enable = true;
    #   openFirewall = true;
    #
    # };
        environment.systemPackages = with pkgs; [
    stable-pkgs.alvr
        ];

        networking.firewall = {
          enable = true;
          allowedTCPPorts = [
            9943
            9944

          ];
          allowedUDPPorts = [
            9943
            9944
          ];
        };

  };

}
