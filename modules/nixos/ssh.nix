{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.ssh;
in
{
  options = {
    modules.ssh.enable = lib.mkEnableOption "enable ssh module";
  };
  config = lib.mkIf cfg.enable {

    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };

  };

}