{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.hyfetch;
in
{
  options = {
    modules.hyfetch.enable = lib.mkEnableOption "enable hyfetch module";
  };
  config = lib.mkIf cfg.enable {

    home.file.".config/neofetch/config.conf".source = ./config.conf;

    home.packages = with pkgs; [
      hyfetch
    ];

  };

}
