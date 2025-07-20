{
  config,
  inputs,
  lib,
  pkgs,
  stable-pkgs,
  hyprland-source,
  zen-browser-source,
  ...
}:
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
  };
in
{

  imports = [
    inputs.home-manager.nixosModules.default
    ../../modules/nixos/default.nix
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
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
    #alvr.enable = true;
    kdeconnect.enable = true;

    waydroid.enable = false;
    virt-manager.enable = true;
  };

  programs = {
    fish.enable = true;
    hyprland = {
      enable = true;
      # package = inputs.nixpkgs-stable.legacyPackages.x86_64-linux.hyprland;
      xwayland.enable = true;
    };
  };
  fileSystems."/mnt/windows-linux-coalition" = {
    device = "/dev/nvme0n1p7";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ]; # ! uid of user
  };

  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.gvfs.enable = true;

  networking.hostName = "Pc"; # Define your hostname.
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    sharedModules = [
      inputs.nixcord.homeModules.nixcord
    ];
    extraSpecialArgs = {
      inherit inputs;
      inherit stable-pkgs;
      inherit hyprland-source;
      inherit zen-browser-source;

      systemConfig = {
        inherit systemModule;
      };
      userConfig = {
        system = {
          specialization = "default";
        };
      };
    };
    users = {
      "user" = import ./home.nix;
    };
  };

  time = {
    timeZone = "Europe/Warsaw";
    hardwareClockInLocalTime = true;
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

  users.users.user = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
      "seat"
    ];
    shell = pkgs.fish;
    useDefaultShell = true;
    packages = with pkgs; [
      nixfmt-rfc-style # formatter

      pavucontrol

      hyfetch

      kdePackages.xwaylandvideobridge # Utility to allow streaming Wayland windows to X applications
      eww

      neovim
      tree

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
