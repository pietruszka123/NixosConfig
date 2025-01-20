{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.wlogout;
in
{
  options = {
    modules.wlogout.enable = lib.mkEnableOption "enable wlogout module";
  };
  config = lib.mkIf cfg.enable {

    programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Sleep";
          #keybind = "q";
        }

      ];
    };
  };

}
