{
  config,
  pkgs,
  inputs,
  stable-pkgs,
  hyprland-source,
  zen-browser-source,
  systemModule,
  systemName,
  ...
}:
let

in
{
  imports = [
    ./modules/home-manager
    inputs.catppuccin.homeModules.catppuccin
    ./users/${config.home.username}
  ];
  config = {
    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
  };
}
