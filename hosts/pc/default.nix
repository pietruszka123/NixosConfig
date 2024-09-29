{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{

  imports = [
    inputs.home-manager.nixosModules.default
    ../../modules/system/default.nix
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

  nixpkgs.config.allowUnfree = true;

  #xdg.portal.enable = true;
  #xdg.portal.extraPortals = [
  #  pkgs.xdg-desktop-portal-gtk
  #  pkgs.xdg-desktop-portal-hyprland
  #];

  # System
  system = {
    powerManagement.enable = false;
    networking.enable = true;
    nvidia = {
      enable = true;
      nvidiaBusId = "PCI:1:00:0";
      amdBusId = "PCI:15:00:0";
    };
    pipewire.enable = true;
    #lemurs.enable = true;

  };

  modules = {
    podman.enable = true;
    steam.enable = true;
  };

  fileSystems."/mnt/windows-linux-coalition" = {
    device = "/dev/nvme0n1p6";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ]; # ! uid of user
  };

  system.greetd.enable = true;
  #  userConfig.system.lemurs.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  programs.hyprland = {
    enable = true;
    package = inputs.nixpkgs-stable.legacyPackages.x86_64-linux.hyprland;
  };
  networking.hostName = "Pc"; # Define your hostname.
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
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

  time.timeZone = "Europe/Warsaw";

  nix.optimise.automatic = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  #Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  programs.fish.enable = true;

  users.users.user = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
      "seat"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [
      # nix neovim language
      nil # lsp
      nixfmt-rfc-style # formatter

      pavucontrol

      prismlauncher

      hyfetch

      # xwaylandvideobridge # Utility to allow streaming Wayland windows to X applications
      waybar # TODO: replace with eww
      eww

      starship

      neovim
      #firefox
      tree

      dolphin

      zulu17
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #brightnessctl # backlight controls
    lshw # a small tool to extract detailed information on the hardware configuration of the machine
    #gcc
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    parted

    btop
    # lemurs
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  #system.copySystemConfiguration = true;

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
