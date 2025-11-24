{
  config,
  pkgs,
  inputs,
  lib,
  stable-pkgs,
  hyprland-source,
  zen-browser-source,
  systemModule,
  systemName,
  systemBaseVersion,
  userName,
  ...
}:
let

in
{
  imports = [
    ./modules/home-manager
    ./users/${userName}
  ]
  ++ lib.optional (builtins.pathExists ./hosts/${systemName}/home.nix) ./hosts/${systemName}/home.nix;
  config = {
    home.username = userName;
    home.homeDirectory = "/home/${userName}";

    home.stateVersion = systemBaseVersion;

    programs.home-manager.enable = true;
  };
}
