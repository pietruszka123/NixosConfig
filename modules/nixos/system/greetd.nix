{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    system.greetd.enable = lib.mkEnableOption "enable greetd module";
  };
  config = lib.mkIf config.system.greetd.enable {
    services.greetd = {
      enable = true;
      vt = 2;
      settings = {
        default_session = {
          command = ''${pkgs.greetd.tuigreet}/bin/tuigreet --time --greeting "Gami to furras" --asterisks --cmd Hyprland'';
        };
      };
    };
    environment.etc."greetd/environments".text = ''
      Hyprland
      fish
      bash
      startxfce4
    '';
  };
}
