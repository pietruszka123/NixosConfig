{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../../modules/home-manager
    inputs.catppuccin.homeModules.catppuccin
  ];
  modules = {
    hyprland = {
      enable = true;
      additional_config = ./hyprland.conf;
    };
    hyprlock.enable = true;
    wallpaper = {
      enable = true;

      hyprpaper.enable = true;
    };

    shells = {
      plugins = {
        tlrc.enable = true;
        starship.enable = true;
        eza.enable = true;
      };
      fish.enable = true;
    };
    shells.any-nix-shell.enable = true;
    ranger.enable = true;

    notification-daemon = {
      swaync.enable = true;
      dunst.enable = false;
    };

    firefox.enable = true;

    tofi.enable = true;

    editors = {
      vscode.enable = true;
      neovim = {
        enable = true;
        default_editor = true;
      };
      android-studio.enable = false;
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

    vlc.enable = true;
    mpv.enable = true;
    obsidian.enable = true;
    game_launchers = {
      r2modman.enable = true;
      ryujinx.enable = true;
      heroic.enable = true;
    };
    wlogout.enable = true;
    wine.enable = true;

    qbittorrent.enable = true;
    bottles.enable = true;

    browsers = {
      floorp.enable = false;
      zen.enable = true;
    };

    file-managers = {
      nautilus.enable = true;
    };
    nixcord.enable = true;
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
  home.packages = with pkgs; [
    mgba
    gitkraken
    unzip
    zip

    nwg-look
    go
    pulsemixer

    tmux

    eza
    unar
    linux-wifi-hotspot
    mate.engrampa
    p7zip

    nerd-fonts.fira-code
    glasstty-ttf

    (callPackage ../../packages/wayland-push-to-talk.nix { })

    # alvr

    mangohud

  ];
  home.pointerCursor = {

    size = 21;
  };

  services.gnome-keyring.enable = true;

  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
    cursors.enable = true;
    kvantum.enable = true;
    gtk.enable = true;
  };
  #gtk.catppuccin.enable = true;
  #qt.style.catppuccin.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

}
