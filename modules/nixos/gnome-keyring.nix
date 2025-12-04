{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.gnome-keyring;
in
{
  options = {
    modules.gnome-keyring.enable = lib.mkEnableOption "enable gnome-keyring module";
  };
  config = lib.mkIf cfg.enable {

    services.gnome.gnome-keyring.enable = true;

    #TODO: make it detect dm
    security.pam.services.hyprland.enableGnomeKeyring = true;
  };

}
