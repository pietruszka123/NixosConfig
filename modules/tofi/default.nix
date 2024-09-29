{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.tofi;
in
{
  options = {
    modules.tofi.enable = lib.mkEnableOption "enable tofi module";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      tofi
    ];

    home.file.".config/tofi/config".source = ./config;

  };
}
