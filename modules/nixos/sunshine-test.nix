{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.sunshine-test;
in
{
  options = {
    modules.sunshine-test.enable = lib.mkEnableOption "enable sunshine-test module";
  };
  config = lib.mkIf cfg.enable {

    services.sunshine = {
      enable = true;
      autoStart = false; # optional: starts Sunshine automatically on login
      capSysAdmin = true;
      openFirewall = true;
    };
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    services.pipewire.extraConfig.pipewire."sunshine-null-sink" = {
      "context.objects" = [
        {
          factory = "adapter";
          args = {
            "factory.name" = "support.null-audio-sink";
            "node.name" = "sink-sunshine-stereo";
            "node.description" = "Sunshine Streaming Sink (Stereo)";
            "media.class" = "Audio/Sink";
            "audio.position" = "FL,FR";
            "monitor.channel-volumes" = true;
          };
        }
      ];

    };

  };

}
