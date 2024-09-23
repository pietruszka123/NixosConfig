{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.alacritty;
in
{
  options = {
    modules.alacritty.enable = lib.mkEnableOption "enable alacritty module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [ alacritty ];

    home.file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;

  };

}
