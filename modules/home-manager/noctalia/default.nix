{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.noctalia;
in
{
  options = {
    modules.noctalia.enable = lib.mkEnableOption "enable noctalia module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      noctalia-shell
    ];

  };

}
