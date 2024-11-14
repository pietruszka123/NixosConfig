{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.terminals.alacritty;
in
{
  options = {
    modules.terminals.alacritty.enable = lib.mkEnableOption "enable alacritty module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [ alacritty ];

    home.file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;
    home.file.".config/alacritty/monokai_charcoal.toml".text = builtins.readFile (
      pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/alacritty/alacritty-theme/11664caf4c2bfae94e006e860042f93b217fc0f7/themes/monokai_charcoal.toml";
        hash = "sha256-64PMHwYGAMUUPT1Q5Dm8V1u8bO4vDQONxe2HdODddXk=";
      }
    );

  };

}
