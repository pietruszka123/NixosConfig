{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.podman;
in
{
  options = {
    modules.podman.enable = lib.mkEnableOption "enable podman module";
  };
  config = lib.mkIf cfg.enable {
    virtualisation.containers.enable = true;
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enable = true;
      };
    };

    #environment.systemPackages = with pkgs; [ nvidia-podman ];

  };
}
