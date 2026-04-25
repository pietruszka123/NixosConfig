{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    systemModule.greetd.enable = lib.mkEnableOption "enable greetd module";
  };
  config = lib.mkIf config.systemModule.greetd.enable {
    services.greetd = {
      enable = true;
      # vt = 2;
      settings = {
        default_session = {
          command = ''${pkgs.tuigreet}/bin/tuigreet --time --greeting "Gami to furras" --cmd start-hyprland'';
        };
      };
    };
    environment.etc."greetd/environments".text = ''
      Hyprland
	  start-hyprland
      fish
      bash
      startxfce4
    '';
  };
}
