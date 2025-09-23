{lib,pkgs,config, ... }:

{

  imports = [
    ./envision.nix
    ./wivrn.nix
    ./monado.nix
  ];

  options = {
    modules.vr.wlx-overlay.enable = lib.mkEnableOption "enable wlx-overlay module";

  };
  config = {
    environment = lib.mkMerge [
      (lib.mkIf config.modules.vr.wlx-overlay.enable {
        systemPackages = [
          pkgs.wlx-overlay-s
        ];
      })
    ];
  };
}
