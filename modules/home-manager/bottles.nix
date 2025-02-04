{
  config,
  lib,
  pkgs,
  inputs,
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

    home.packages = with inputs.nixpkgs-stable.legacyPackages.x86_64-linux; [
      bottles-unwrapped

    ];

  };

}
