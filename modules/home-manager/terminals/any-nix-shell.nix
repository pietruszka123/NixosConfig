{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.shells.any-nix-shell;
in
{
  options = {
    modules.shells.any-nix-shell.enable = lib.mkEnableOption "enable any-nix-shell module";
  };
  config = lib.mkIf cfg.enable {

	home.file.".config/fish/conf.d/any-nix-shell.fish".text = ''any-nix-shell fish --info-right | source'';

    home.packages = with pkgs; [
      any-nix-shell
    ];

  };

}
