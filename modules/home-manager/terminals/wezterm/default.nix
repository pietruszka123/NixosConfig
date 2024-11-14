{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.terminals.wezterm;
in
{
  options = {
    modules.terminals.wezterm.enable = lib.mkEnableOption "enable wezterm module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [

      wezterm

    ];

  };

}
