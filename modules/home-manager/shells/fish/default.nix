{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.shells.fish;
in
{
  options = {
    modules.shells.fish.enable = lib.mkEnableOption "enable Fish module";
  };
  config = lib.mkIf cfg.enable {

    # home.file.".config/fish/config.fish".source = ./config.fish;

    # home.packages = with pkgs; [ starship ];

    programs.fish = {
      enable = true;
      interactiveShellInit = builtins.readFile ./config.fish;
      shellAliases = lib.mkMerge [
        (lib.mkIf (config.modules.editors.neovim.enable == true) {
          "v" = "nvim";
        })
      ];
      #   plugins = [

      #     {
      #       name = "tide";
      #       src = pkgs.fishPlugins.tide;
      #     }
      #   ];

    };
  };

}
