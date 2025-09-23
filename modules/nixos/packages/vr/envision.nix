{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.vr.envision;
in
{
  options = {
    modules.vr.envision.enable = lib.mkEnableOption "enable envision module";
  };
  config = lib.mkIf cfg.enable {

    programs.envision = {
      enable = true;
    };
  };

}
