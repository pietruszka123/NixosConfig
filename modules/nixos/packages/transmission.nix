{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.transmission;
in
{
  options = {
    modules.transmission.enable = lib.mkEnableOption "enable transmission module";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      transmission_4-gtk
      transgui
    ];

    #    services.transmission = {
    #      enable = true;
    # settings = {
    #   download-dir = "${config.services.transmission.home}/Downloads";
    # };
    #   };

  };

}
