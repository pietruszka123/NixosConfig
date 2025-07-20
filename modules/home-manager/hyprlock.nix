{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.hyprlock;
in
{
  options = {
    modules.hyprlock.enable = lib.mkEnableOption "enable hyprlock module";
  };
  config = lib.mkIf cfg.enable {

    programs.hyprlock = {
      enable = true;
      
    };

  };

}
