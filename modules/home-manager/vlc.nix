{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.vlc;
in
{
  options = {
    modules.vlc.enable = lib.mkEnableOption "enable vlc module";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ vlc ];

  };

}
