{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.nixcord;
in
{
  options = {
    modules.nixcord.enable = lib.mkEnableOption "enable nixcord module";
  };
  config = lib.mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
      config = {
        autoUpdate = true;

        enabledThemes = [
          "https://luckfire.github.io/amoled-cord/src/amoled-cord.css"
        ];
        themeLinks = [
          "https://luckfire.github.io/amoled-cord/src/amoled-cord.css"
        ];
        plugins = {
          callTimer = {
            enable = true;

          };
          disableCallIdle.enable = true;
          fakeNitro = {
            enable = true;
            enableEmojiBypass = true;
            enableStickerBypass = true;
            enableStreamQualityBypass = true;
          };
          fixYoutubeEmbeds.enable = true;
          petpet.enable = true;
          previewMessage.enable = true;
          relationshipNotifier.enable = true;
          volumeBooster.enable = true;
          youtubeAdblock.enable = true;
        };
      };

    };
  };

}
