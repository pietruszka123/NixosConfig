{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [

    ../../modules/home-manager
    inputs.catppuccin.homeManagerModules.catppuccin
  ];
  modules = {
    firefox.enable = true;
    tofi.enable = true;
    hyprland = {
      enable = true;

      additional_config = ./hyprland.conf;
    };
    shells.fish.enable = true;
    ranger.enable = true;
    notification-daemon = {
      swaync.enable = true;
      dunst.enable = false;
    };

    wallpaper = {
      enable = true;

      hyprpaper.enable = true;
    };
    wlogout.enable = true;

    atuin.enable = true;

    terminals = {
      alacritty.enable = true;
      kitty.enable = false;

    };
    discord.enable = false;
    editors = {
      android-studio.enable = true;

      neovim = {
        enable = true;
        default_editor = true;
      };
    };

    waybar.enable = true;

    hyfetch.enable = true;

    prism-launcher.enable = true;
  };
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    #mgba
    gitkraken
    unzip
    #nwg-look
    #go
    nerd-fonts.fira-code
    eza
  ];
  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
    cursors.enable = true;
    kvantum.enable = true;
    gtk.enable = true;
  };
}
