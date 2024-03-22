{ config, pkgs, ... }:

{
  imports = [

    ../../modules
  ];
  modules.hyprland.enable = true;
  modules.fish.enable = true;
  modules.ranger.enable = true;
  modules.alacritty.enable = true;
  modules.wezterm.enable = false;

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.gitkraken
    pkgs.unzip
    pkgs.nwg-look
    pkgs.mesa
    pkgs.go
    #pkgs.git-credential-manager
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  #home.pointerCursor = {
  #      gtk.enable = true;
  #      package = pkgs.vanilla-dmz;
  #      name = "Vanilla-DMZ";
  #      #package= pkgs.catppuccin-cursors.mochaLavender;
  #      #name = "catppuccin-Mocha-Lavender";
  #      size = 24;	
  #};
}
