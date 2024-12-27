{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [

    ./r2modman.nix
  ];
  options = {
    modules.game_launchers.ryujinx.enable = lib.mkEnableOption "enable wezterm module";
  };
  config = {
    home.packages = lib.mkIf config.modules.game_launchers.ryujinx.enable [
      pkgs.ryujinx
    ];

  };
}
