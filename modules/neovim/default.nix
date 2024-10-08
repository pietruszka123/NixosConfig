{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.neovim;
in
{
  options = {
    modules.neovim.enable = lib.mkEnableOption "enable neovim module";
  };
  config = lib.mkIf cfg.enable {

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        nil
      ];
    };

    home.packages = with pkgs; [
      python3 # needed for luarocks
      gcc
    ];

  };

}
