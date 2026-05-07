{
  config,
  lib,
  pkgs,
  inputs,
  stable-pkgs,
  ...
}:

let
  cfg = config.modules.bottles;
in
{
  options = {
    modules.bottles.enable = lib.mkEnableOption "enable bottles module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      stable-pkgs.bottles
    ];

  };

}
