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

    tofi.enable = false;

    editors = {
      vscode.enable = true;
      neovim = {
        enable = true;
        default_editor = true;
      };
      # android-studio.enable = false;
    };
    waybar.enable = true;
    quickshell.enable = true;

    atuin.enable = true;
    terminals = {
      alacritty.enable = true;
      wezterm.enable = false;
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
      ryujinx.enable = false;
      heroic.enable = true;
      osu.enable = false;
    };
    wlogout.enable = true;
    wine.enable = false;

    qbittorrent.enable = true;
    bottles.enable = true;

    browsers = {
      floorp.enable = false;
      zen.enable = false;
    };

    file-managers = {
      nautilus.enable = true;
    };
    nixcord.enable = true;
    mpd.enable = false;
    syncthing.enable = true;
    feishin.enable = true;
    vicinae.enable = true;
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
    pulsemixer

    tmux

    unar
    # linux-wifi-hotspot
    mate.engrampa
    p7zip

    nerd-fonts.fira-code
    glasstty-ttf

    (callPackage ../../packages/wayland-push-to-talk.nix { })

    # alvr

    mangohud

    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    adwaita-icon-theme

  ];
  home.pointerCursor = {
    size = 21;
  };

  programs.git-credential-oauth.enable = true;

  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
    cursors.enable = true;
    kvantum.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

}
