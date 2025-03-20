{
  config,
  lib,
  pkgs,
  inputs,
  zen-browser-source,
  ...
}:

let
  cfg = config.modules.browsers.zen;

in
{
  options = {
    modules.browsers.zen.enable = lib.mkEnableOption "enable Zen browser module";
  };

  config = lib.mkIf cfg.enable {

    programs.zen = {
      enable = true;
      package = zen-browser-source.default;

      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "extensions.autoDisableScopes" = 0;
	    "general.autoScroll" = 1;
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
