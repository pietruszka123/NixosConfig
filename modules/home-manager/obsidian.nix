{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.obsidian;
in
{
  options = {
    modules.obsidian.enable = lib.mkEnableOption "enable obsidian module";
  };
  config = lib.mkIf cfg.enable {

    #    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      obsidian

    ];
  };

}
