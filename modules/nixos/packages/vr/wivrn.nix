{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.vr.wivrn;
in
{
  options = {
    modules.vr.wivrn.enable = lib.mkEnableOption "enable wivrn module";
  };
  config = lib.mkIf cfg.enable {

    services.wivrn = {
      enable = true;
      openFirewall = true;
	   defaultRuntime = true;
    };

  };

}
