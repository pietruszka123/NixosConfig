{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.waybar;
in
{
  options = {
    modules.waybar.enable = lib.mkEnableOption "enable waybar module";
  };
  config = lib.mkIf cfg.enable {
    home.file.".config/waybar/mocha.css".text = builtins.readFile (
      pkgs.fetchurl {
        url = "https://github.com/catppuccin/waybar/releases/download/v1.1/mocha.css";
        hash = "sha256-llnz9uTFmEiQtbfMGSyfLb4tVspKnt9Fe5lo9GbrVpE=";
      }
    );
    home.file.".config/waybar/style.css".source = ./style.css;
    home.file.".config/waybar/config".source = ./config;

    home.packages = with pkgs; [
      nerd-fonts.fantasque-sans-mono
      playerctl
    ];

  };

}
