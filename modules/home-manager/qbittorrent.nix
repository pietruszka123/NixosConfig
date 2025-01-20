{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.qbittorrent;
in
{
  options = {
    modules.qbittorrent.enable = lib.mkEnableOption "enable qbittorrent module";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      qbittorrent

    ];

  };

}
