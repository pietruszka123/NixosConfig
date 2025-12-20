{
  config,
  lib,
  pkgs,
  inputs,
  ...
}@args:

let
  cfg = config.modules.firefox;
in
{
  options = {
    modules.firefox.enable = lib.mkEnableOption "enable firefox module";
  };
  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
    };
    programs.firefox = {
      enable = true;

      profiles = {
		default = (import ../browsers/firefox_base_config.nix (args));
	  }; 
    };

  };

}
