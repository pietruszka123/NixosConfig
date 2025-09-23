{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.vr.monado;
in
{
  options = {
    modules.vr.monado.enable = lib.mkEnableOption "enable monado module";
  };
  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs; [ monado-vulkan-layers ];

    services.monado = {
      enable = true;

    };

  };

}
