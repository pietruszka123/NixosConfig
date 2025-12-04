{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.file-managers;
in
{
  options = {
    modules.file-managers.nautilus.enable = lib.mkEnableOption "enable Nautilus module";
  };
  config = {

    home.packages = lib.mkMerge [
      (lib.mkIf (cfg.nautilus.enable == true) [
        pkgs.nautilus
        (pkgs.runCommandLocal "nautilus-portal" { } ''
          mkdir -p $out/share/xdg-desktop-portal/portals
          cat > $out/share/xdg-desktop-portal/portals/nautilus.portal <<EOF
          [portal]
          DBusName=org.gnome.Nautilus
          Interfaces=org.freedesktop.impl.portal.FileChooser
          EOF
        '')

      ])

      # (lib.mkIf (cfg.nautilus.enable == true && config.modules.terminals.alacritty.enable == true) [
      #   pkgs.nautilus-open-any-terminal
      #   pkgs.nautilus-python
      # ])

    ];
    xdg.portal.config = {
      hyprland = lib.mkIf (config.modules.hyprland.enable == true && cfg.nautilus.enable == true) {
        "org.freedesktop.impl.portal.FileChooser" = "nautilus";
      };
    };

  };

}
