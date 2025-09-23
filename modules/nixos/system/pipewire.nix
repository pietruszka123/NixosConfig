{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    systemModule.pipewire.enable = lib.mkEnableOption "enable pipewire module";

  };
  config = lib.mkIf config.systemModule.pipewire.enable {

    security.rtkit.enable = true;

    environment.systemPackages = with pkgs; [
      # pulseaudio

      faudio
    ];

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # extraConfig.pipewire-pulse."92-low-latency" = {
      #   "context.properties" = [
      #     {
      #       name = "libpipewire-module-protocol-pulse";
      #       args = { };
      #     }
      #   ];
      #   "pulse.properties" = {
      #     "pulse.min.req" = "1024/48000";
      #     "pulse.max.req" = "1024/48000";
      #     "pulse.min.quantum" = "1024/48000";
      #   };
      #
      # };

      extraConfig.pipewire-pulse."92-low-latency" = {
        "context.properties" = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = { };
          }
        ];
        "pulse.properties" = {
          "pulse.min.req" = "32/48000";
          "pulse.default.req" = "32/48000";
          "pulse.max.req" = "32/48000";
          "pulse.min.quantum" = "32/48000";
          "pulse.max.quantum" = "32/48000";
        };
        "stream.properties" = {
          "node.latency" = "32/48000";
          "resample.quality" = 1;
        };
      };

      wireplumber.enable = true;
      wireplumber.configPackages = [
        (pkgs.writeTextDir "share/wireplumber/main.lua.d/99-alsa-lowlatency.lua" ''
                    alsa_monitor.rules = {
                      {
                        matches = [{"alsa.card_name" = "Live! Cam Chat HD VF0790";}];
                        apply_properties = {
          		["audio.format"] = "S16LE",
                          ["audio.rate"] = "96000", -- for USB soundcards it should be twice your desired rate
                        ["api.alsa.period-size"] = 2,
          	      },
                      },
                    }
        '')

      ];

    };
  };
}
