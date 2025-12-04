{
  config,
  inputs,
  lib,
  pkgs,
  stable-pkgs,
  hyprland-source,
  zen-browser-source,
  systemName,
  # caelestia-shell-source,
  # caelestia-cli-source,
  ...
}@args:
let

  systemModule = {
    powerManagement.enable = false;
    networking.enable = true;
    nvidia = {
      enable = true;
      nvidiaBusId = "PCI:1:00:0";
      amdBusId = "PCI:15:00:0";
    };
    pipewire.enable = true;
    #lemurs.enable = true;
    greetd.enable = true;
    bluetooth.enable = true;
    openvpn.enable = true;
    opentabletdriver.enable = true;
    ratbag.enable = false;
  };
in
{

  imports = [
    (import ../../base.nix (args // { inherit systemModule; }))
    ../../modules/nixos/default.nix
    ./hardware-configuration.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      # systemd-boot.enable = true;
      grub.enable = true;
      grub.device = "nodev";
      grub.useOSProber = true;
      grub.efiSupport = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" ];
  };

  #TODO: make it work from home manager
  environment.variables.EDITOR = "nvim";

  nixpkgs.config.allowUnfree = true;

  systemModule = systemModule;

  modules = {
    podman.enable = true;
    steam.enable = true;
    ssh.enable = true;
    transmission.enable = false;
    flatpak.enable = true;
    alvr.enable = true;
    kdeconnect.enable = true;

    waydroid.enable = false;
    virt-manager.enable = true;
    vr = {
      envision.enable = false;
      wivrn.enable = false;
      monado.enable = false;
      wlx-overlay.enable = true;
    };
    ghidra.enable = true;
    # gnome-keyring.enable = true;
  };

  programs = {
    fish.enable = true;
    hyprland = {
      enable = true;
      # package = inputs.nixpkgs-stable.legacyPackages.x86_64-linux.hyprland;
      xwayland.enable = true;
    };
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "alacritty";
    };

  };
  fileSystems."/mnt/windows-linux-coalition" = {
    device = "/dev/disk/by-uuid/2CFAA70BFAA6CFFE";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ]; # ! uid of user
  };
  fileSystems."/mnt/test" = {
    device = "dev/disk/by-uuid/8d177aa1-7179-4ff6-abd9-0f0a97016190";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "noatime"
    ];
  };

  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.gvfs.enable = true;

  networking.hostName = "Nixu_machine_UwU"; # Define your hostname.

  time = {
    timeZone = "Europe/Warsaw";
    hardwareClockInLocalTime = true;
  };

  boot.loader.grub = {
    minegrub-world-sel = {
      enable = true;
      customIcons = [
        {
          name = "nixos";
          lineTop = "NixOS (23/11/2023, 23:03)";
          lineBottom = "Survival Mode, No Cheats, Version: 23.11";
          # Icon: you can use an icon from the remote repo, or load from a local file
          imgName = "nixos";
          # customImg = builtins.path {
          #   path = ./nixos-logo.png;
          #   name = "nixos-img";
          # };
        }
      ];
    };
  };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  nix = {
    optimise.automatic = true;

    # Flakes
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
  users.users.user = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
      "seat"
      "podman"
      "wireshark"
    ];
    shell = pkgs.fish;
    useDefaultShell = true;
    packages = with pkgs; [
      nixfmt-rfc-style # formatter

      pavucontrol

      hyfetch

      eww

      # neovim
      tree

      # caelestia-shell-source.with-cli
      # caelestia-cli-source.with-shell

      # kdePackages.dolphin
    ];
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  environment.systemPackages = with pkgs; [
    #brightnessctl # backlight controls
    lshw # a small tool to extract detailed information on the hardware configuration of the machine
    vim
    wget
    parted

    (btop.override {
      cudaSupport = true;
    })
    # lemurs
    btrfs-progs
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .

  system.stateVersion = "24.05"; # Did you read the comment?
}
