{
  config,
  inputs,
  lib,
  pkgs,
  stable-pkgs,
  ...
}:
let
  systemModule = {
    powerManagement.enable = true;
    networking.enable = true;

    nvidia = {
      enable = true;
      nvidiaBusId = "PCI:1:00:0";
      intelBusId = "PCI:0:2:0";
    };
    pipewire.enable = false;
    #lemurs.enable = true;

    greetd.enable = true;
    bluetooth.enable = false;

  };
in
{
  imports = [
    # Include the results of the hardware scan.
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
  nixpkgs.config.allowUnfree = true;
  fileSystems."/mnt/windows" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ]; # ! uid of user
  };


fileSystems = {
  "/".options = [ "compress=zstd" ];
  "/home".options = [ "compress=zstd" ];
  "/nix".options = [ "compress=zstd" "noatime" ];
};



  # System
  systemModule = systemModule;

  modules.ssh.enable = true;
  modules.steam.enable = true;

  services.fail2ban.enable = true;

  services.xserver.enable = false;
  services.xserver.displayManager.startx.enable = false;
  programs.hyprland = {
    enable = true;
    # package = inputs.nixpkgs-stable.legacyPackages.x86_64-linux.hyprland;
  };
  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = [ "on-the-go" ];
      systemModule.nvidia.nvidia_prime = lib.mkForce "offload";
      home-manager.extraSpecialArgs = lib.mkForce {
        inherit inputs;
        inherit stable-pkgs;
        systemConfig = {
          inherit systemModule;
        };

        userConfig = {
          system = {
            specialization = "on-the-go";
          };
        };
      };

      #hardware.nvidia = {
      #  prime.offload.enable = lib.mkForce true;
      #  prime.offload.enableOffloadCmd = lib.mkForce true;
      #  prime.sync.enable = lib.mkForce false;
      #};
    };
  };
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit stable-pkgs;
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

  # networking.hostName = "minecraft-server-laptop"; # Define your hostname.
  networking.hostName = "nixos"; # Define your hostname.

  # Pick only one of the below networking options.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Storage Optimization
  nix.optimise.automatic = true;

  #Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  programs.fish.enable = true;
  # zsh
  #programs.zsh.enable = true;
  #services.displayManager.enable = true;
  #services.displayManager.execCmd = "${pkgs.lemurs}/bin/lemurs";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    user = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "input"
        "networkmanager"
        "seat"
      ]; # Enable ‘sudo’ for the user.
      shell = pkgs.fish;
      packages = with pkgs; [
        # nix neovim language
        nil # lsp
        nixfmt-rfc-style # formatter

        #tofi # Tiny dynamic menu for Wayland

        #pavucontrol

        starship # TODO: move to fish config

        hyfetch

        neovim
        tree
      ];
    };
    minecraft-server = {
      isNormalUser = true;
      shell = pkgs.fish;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    brightnessctl # backlight controls
    lshw # a small tool to extract detailed information on the hardware configuration of the machine
    #gcc
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    parted

    unzip
    zip

    hyfetch
    btop
    tmux
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
  system.stateVersion = "23.11"; # Did you read the comment?

}
