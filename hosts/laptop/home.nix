{ config, pkgs, ... }:

{
  imports = [ ../../modules ];
  modules.hyprland.enable = true;
  modules.fish.enable = true;
  modules.ranger.enable = true;

  modules.dunst.enable = true;


  #Terminals
  modules.alacritty.enable = true;
  #modules.wezterm.enable = true;
  modules.kitty.enable = true;

  modules.discord.enable = true;

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.mgba
    pkgs.gitkraken
    pkgs.unzip
    pkgs.nwg-look
    pkgs.go
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  home.pointerCursor = {
    gtk.enable = true;
    #package = pkgs.vanilla-dmz;
    #name = "Vanilla-DMZ";
    package = pkgs.catppuccin-cursors.mochaLavender;
    name = "Catppuccin-Mocha-Lavender";
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Catppuccin-Mocha-Lavender";
    };
  };
}
