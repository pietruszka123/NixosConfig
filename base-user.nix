{
  config,
  pkgs,
  inputs,
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
    inputs.catppuccin.homeModules.catppuccin
    ./users/${userName}
  ];
  config = {
    home.username = userName;
    home.homeDirectory = "/home/${userName}";

    home.stateVersion = systemBaseVersion;

    programs.home-manager.enable = true;
  };
}
