{
  config,
  pkgs,
  inputs,
  ...
}:
{
  modules = {
    hyprland = {
      additional_config = ./hyprland.conf;
    };
  };
}
