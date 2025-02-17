{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemModule.openvpn;
in
{
  options = {
    systemModule.openvpn.enable = lib.mkEnableOption "enable openvpn module";
  };
  config = lib.mkIf cfg.enable {

    networking.wireguard.enable = true;

    environment.systemPackages = with pkgs; [
      networkmanager-openvpn
      openvpn
    ];

  };

}
