{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.onlyoffice;
in
{
  options = {
    modules.onlyoffice.enable = lib.mkEnableOption "enable onlyoffice module";
  };
  config = lib.mkIf cfg.enable {

    programs.onlyoffice = {
      enable = true;
    };
  };

}
