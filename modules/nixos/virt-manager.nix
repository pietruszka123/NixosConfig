{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.virt-manager;
in
{
  options = {
    modules.virt-manager.enable = lib.mkEnableOption "enable virt-manager module";
  };
  config = lib.mkIf cfg.enable {

    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [ "user" ];

    virtualisation.libvirtd.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;
  };

}
