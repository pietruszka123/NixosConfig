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
	noctalia.enable = true;
  };
}
