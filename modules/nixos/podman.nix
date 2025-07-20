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
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enable = true;
      };
      containers = {
        enable = true;
      };
    };
    hardware.nvidia-container-toolkit.enable = true;


    environment.systemPackages = with pkgs; [
      dive
      podman-tui
      podman-compose
    ];

  };
}
