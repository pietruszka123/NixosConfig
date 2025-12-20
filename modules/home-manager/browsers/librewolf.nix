{
  config,
  lib,
  pkgs,
  ...
}@args:

let
  cfg = config.modules.browsers.librewolf;
in
{
  options = {
    modules.browsers.librewolf.enable = lib.mkEnableOption "enable librewolf module";
  };
  config = lib.mkIf cfg.enable {

    programs.librewolf = {

      enable = true;
      profiles = {

        default = (import ./firefox_base_config.nix (args));

      };

    };

  };

}
