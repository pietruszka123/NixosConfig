{
  config,
  lib,
  stable-pkgs,
  ...
}:

let
  cfg = config.modules.merkuro;
in
{
  options = {
    modules.merkuro.enable = lib.mkEnableOption "enable merkuro module";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with stable-pkgs; [
      kdePackages.merkuro
    ];

  };

}
