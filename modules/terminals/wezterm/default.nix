{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.wezterm;
in
{
  options = {
    modules.wezterm.enable = lib.mkEnableOption "enable wezterm module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [

      wezterm

    ];

  };

}
