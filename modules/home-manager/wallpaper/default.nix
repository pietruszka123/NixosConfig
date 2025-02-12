args@{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.wallpaper;
  wallpapers = {
	evening = "sleepy.jpg";
	day = "gaming.jpg";
	time = "19";
  };
in
{
  options = {
    modules.wallpaper.enable = lib.mkEnableOption "enable wallpaper module";
  };

  imports = [
    (import ./hyprpaper (args // {wallpaper = wallpapers;}) )
  ];

  config = lib.mkIf cfg.enable {

    home.file = {
      "wallpapers/sleepy.jpg".source = pkgs.fetchurl {
        url = "https://cdn.steamstatic.com/steamcommunity/public/images/items/2861720/386c658bc267ea1a1973abd8f40990d66233caae.jpg";
        hash = "sha256-6NeYZu//gfNdfFo3n5VTA5cjJKWwwuKuIXv7sc4vtWE=";
      };
      "wallpapers/gaming.jpg".source = pkgs.fetchurl {
        url = "https://cdn.steamstatic.com/steamcommunity/public/images/items/2861720/87fd4f413d9ad44e19cd2876a48e25b4025dce74.jpg";
        hash = "sha256-G9NDQ5Wrzx3jkjo2GtpMMcjUtDC5dYrWPTBUY87MpyM=";
      };

    };

  };

}
