{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.modules.browsers.floorp;
in
{
  options = {
    modules.browsers.floorp.enable = lib.mkEnableOption "enable floorp module";
  };
  config = lib.mkIf cfg.enable {

    programs.floorp = {
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
            bitwarden
          ];
        };
      };
    };
  };

}
