{
  config,
  home,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.shells;

in
{
  options = {

    modules.shells.tlrc.enable = lib.mkEnableOption "Enable tlrc";
  };

  imports = [
    ./fish
  ];
  config = {

    home.packages = if (cfg.tlrc.enable == true) then [ pkgs.tlrc ] else [ ];

  };

}
