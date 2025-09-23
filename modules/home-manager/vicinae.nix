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
    services.vicinae = {
      enable = true; # default: false
      autoStart = true; # default: true
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
      # package = # specify package to use here. Can be omitted.
    };
  };

}
