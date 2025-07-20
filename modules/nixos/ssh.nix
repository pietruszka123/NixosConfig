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
      ports = [ 2137 ];
      settings = {
        PasswordAuthentication = true;
        KbdInteractiveAuthentication = false;
        # AllowUsers = [ "minecraft-server" ]; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };

  };

}
