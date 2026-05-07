{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.vicinae;
in
{
  options = {
    modules.vicinae.enable = lib.mkEnableOption "enable vicinae module";
  };
  config = lib.mkIf cfg.enable {
    programs.vicinae = {
      enable = true; # default: false
      systemd = {
        autoStart = true;
        enable = true;
		target = "hyprland-session.target";
      };
      settings = {
        faviconService = "twenty";
        font = {
          size = 10;
        };
        popToRootOnClose = false;
        rootSearch = {
          searchFiles = false;
        };
        theme = {
          iconTheme = "Catppuccin Mocha Lavender";
          name = "dracula_plus.json";
        };
        window = {
          csd = true;
          opacity = 0.95;
          rounding = 10;
        };
      };
    };
  };

}
