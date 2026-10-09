{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.gstreamer;
in
{
  options = {
    modules.gstreamer.enable = lib.mkEnableOption "enable gstreamer module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [

      gst_all_1.gstreamer
      # Common plugins like "filesrc" to combine within e.g. gst-launch
      gst_all_1.gst-plugins-base
      # Specialized plugins separated by quality
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-ugly
      # Plugins to reuse ffmpeg to play almost every video format
      gst_all_1.gst-libav
      # Support the Video A
      gst_all_1.gst-vaapi
    ];

  };

}
