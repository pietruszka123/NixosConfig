{ inputs, ... }:
let
in

{
  id = 0;
  name = "default";
  isDefault = true;
  settings = {
    "extensions.autoDisableScopes" = 0;
    "middlemouse.paste" = false;
    "widget.use-xdg-desktop-portal.file-picker" = 1;
    "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
    "layout.css.prefers-color-scheme.content-override" = 0;
    "general.autoScroll" = true;

    "media.ffmpeg.vaapi.enabled" = true;
    "media.hardware-video-decoding.force-enabled" = true;
    "media.rdd-ffmpeg.enabled" = true;
    "media.av1.enabled" = true;
    "gfx.x11-egl.force-enabled" = true;
    "widget.dmabuf.force-enabled" = true;
	"browser.nova.enabled" = false;
  };

  extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
    ublock-origin
    darkreader
    sponsorblock
    youtube-shorts-block
    return-youtube-dislikes
    bitwarden
  ];

}
