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
    hyprland = {
      enable = true;
      additional_config = ./hyprland.conf;
    };
    shells.fish.enable = true;
    ranger.enable = true;

    dunst.enable = true;

    firefox.enable = true;

    tofi.enable = true;

    editors = {
      vscode.enable = true;
      neovim = {
        enable = true;
        default_editor = true;
      };
    };
    waybar.enable = true;

    atuin.enable = true;
    terminals = {
      alacritty.enable = true;
      wezterm.enable = true;
      kitty.enable = true;
    };
    discord.enable = true;
    krita.enable = true;


    prism-launcher.enable = true;
  };

  #programs.atuin = {
  #  enable = true;
  #};

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.mgba
    pkgs.gitkraken
    pkgs.unzip
    pkgs.nwg-look
    pkgs.go
    pkgs.playerctl
    pkgs.pulsemixer

    pkgs.tmux

    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })

    (pkgs.callPackage ../../packages/wayland-push-to-talk.nix { })

  ];
  catppuccin = {
    #    enable = true;
    flavor = "mocha";
    accent = "lavender";
    pointerCursor.enable = true;
  };
  gtk.catppuccin.enable = true;
  qt.style.catppuccin.enable = true;
  # home.pointerCursor = {
  #   gtk.enable = true;
  #   #package = pkgs.vanilla-dmz;
  #   #name = "Vanilla-DMZ";
  #   package = pkgs.catppuccin-cursors.mochaLavender;
  #   name = "catppuccin-Mocha-Lavender";
  #   size = 24;
  #   x11 = {
  #     enable = true;
  #     defaultCursor = "catppuccin-Mocha-Lavender";
  #   };
  # };
}
