{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    system.pipewire.enable = lib.mkEnableOption "enable pipewire module";

  };
  config = lib.mkIf config.system.pipewire.enable {

    security.rtkit.enable = true;

    environment.systemPackages = with pkgs; [ pulseaudio ];

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

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
