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

    home.packagees = with pkgs; [
      hyfetch
    ];

  };

}
