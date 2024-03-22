{ config, lib, ... }: {
  options = {
    system.networking.enable = lib.mkEnableOption "enable pipewire module";
  };
  config = lib.mkIf config.system.networking.enable {

    networking.wireless.enable = true;
    networking.wireless.userControlled.enable = true;

    # TODO: load networks from file
    networking.wireless.networks = {
      "Microwave phone".pskRaw =
        "6fd96e0987f0cbe72306bc22f0a3fc2004b95b6c38f6dec0825d170cb2981313";

      "B3".pskRaw =
        "3c39665e2595e7c5520f892a7d6e752506dff183e7b744f5d1600733936962e0";

      "No Internet Connection".pskRaw =
        "01ef28fe1a4fd7aa9240e42ed49c87fc2f35ecf692cbdee38de85060235df4c4";

    };

  };

}
