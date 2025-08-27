{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [

    ./osu.nix
    ./r2modman.nix
  ];
  options = {
    modules.game_launchers.ryujinx.enable = lib.mkEnableOption "enable wezterm module";
    modules.game_launchers.heroic.enable = lib.mkEnableOption "enable heroic launcher module";

  };
  config = {
    home = lib.mkMerge [
      (lib.mkIf config.modules.game_launchers.ryujinx.enable {
        packages = [
          pkgs.ryujinx
        ];
      })
      (lib.mkIf config.modules.game_launchers.heroic.enable {
        packages = [
          pkgs.heroic
        ];
      })
    ];
  };
}
