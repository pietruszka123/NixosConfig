{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.userConfig.system.lemurs;
  xcfg = config.services.xserver;
in
{
  options = {
    userConfig.system.lemurs.enable = lib.mkEnableOption "enable template module";
  };
  config = lib.mkIf cfg.enable {
    #    environment.etc."pam.d/lemurs".text = ''
    #	# Account management.
    #	account required pam_unix.so # unix (order 10900)
    #
    #	# Authentication management.
    #	auth sufficient pam_unix.so likeauth nullok try_first_pass # unix (order 11500)
    #	auth required pam_deny.so # deny (order 12300)
    #
    #	# Password management.
    #	password sufficient pam_unix.so nullok yescrypt # unix (order 10200)
    #
    #	# Session management.
    #	session required pam_env.so conffile=/etc/pam/environment readenv=0 # env (order 10100)
    #	session required pam_unix.so # unix (order 10200)
    #	session optional pam_loginuid.so # loginuid (order 10300)
    ##	session required TODO pam package/lib/security/pam_lastlog.so silent # lastlog (order 10700)
    #	session optional ${config.systemd.package}/lib/security/pam_systemd.so # systemd (order 12000)
    #
    #    '';

    environment.etc."lemurs/config.toml".source = ./lemurs.toml;

    #security.pam.services.login = {

    #    enable = lib.mkForce true;
    #    #configFile =
    #};
    services.accounts-daemon.enable = true;

    services.dbus.packages = [ pkgs.lemurs ];

    systemd.user.services.dbus.wantedBy = [ "default.target" ];
    security.polkit.enable = true;

    systemd.services.lemurs-display-manager = {
      description = "Lemurs Display Manager";
      wantedBy = [ "multi-user.target" ];
      enable = true;

      serviceConfig = {
        ExecStart = "${pkgs.lemurs}/bin/lemurs";
        StandardInput = "tty";
        TTYPath = "/dev/tty2";
        TTYReset = "yes";
        TTYVHangup = "yes";
        Type = "idle";
      };
      after = [
        "systemd-user-sessions.service"
        "plymouth-quit-wait.service"
        "getty@tty2.service"

      ];

      aliases = [
        "display-manager.service"

      ];

    };
  };
}
