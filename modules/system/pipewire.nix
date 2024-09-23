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

      extraConfig.pipewire = {
        "10-clock-rate" = {
          "context.properties" = {
            "default.clock.rate" = 44100;
          };
        };

      };

    };
  };
}
