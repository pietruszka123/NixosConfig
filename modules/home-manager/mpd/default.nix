{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfg = config.modules.mpd;
in
{
  options = {
    modules.mpd.enable = lib.mkEnableOption "enable mpd module";
  };
  config = lib.mkIf cfg.enable {

    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/music";
      network.listenAddress = "/tmp/mpd_socket";
    };

  };

}
