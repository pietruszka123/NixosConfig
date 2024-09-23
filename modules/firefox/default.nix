{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

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
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "extensions.autoDisableScopes" = 0;
          };

          extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
            ublock-origin
            darkreader
            sponsorblock
            youtube-shorts-block
            return-youtube-dislikes
            shinigami-eyes
          ];
        };
      };
    };

  };

}
