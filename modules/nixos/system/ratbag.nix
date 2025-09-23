{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.systemModule.ratbag;
in
{
  options = {
	systemModule.ratbag.enable = lib.mkEnableOption "enable ratbag module";
  };
  config = lib.mkIf cfg.enable {
    services.ratbagd.enable = true;
  };

}
