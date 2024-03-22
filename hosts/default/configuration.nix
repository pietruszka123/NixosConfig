{ config, inputs, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    inputs.home-manager.nixosModules.default
    ../../modules/system/default.nix

  ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  # System
  system.powerManagement.enable = true;
  system.networking.enable = true;
  system.nvidia.enable = true;
  system.pipewire.enable = true;

  programs.hyprland.enable = true;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
    users = { "user" = import ./home.nix; };
  };

  # TODO: look at it
  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Storage Optimization
  nix.optimise.automatic = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  environment.sessionVariables = { DOTNET_ROOT = "${pkgs.dotnet-sdk}"; };

  #Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = [ "on-the-go" ];
      system.nvidia.nvidia_prime = lib.mkForce "offload";
      #hardware.nvidia = {
      #  prime.offload.enable = lib.mkForce true;
      #  prime.offload.enableOffloadCmd = lib.mkForce true;
      #  prime.sync.enable = lib.mkForce false;
      #};
    };
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true; 

  # Fish
  programs.fish.enable = true;
  # zsh
  #programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    packages = with pkgs; [
      #gnumake
      #cmake

      # nix neovim language
      nil # lsp
      nixfmt # formatter

      # github
      #gh

      tofi # Tiny dynamic menu for Wayland

      pavucontrol

      neofetch

      # Screenshots
      grim
      slurp

      xwaylandvideobridge # Utility to allow streaming Wayland windows to X applications
      waybar # TODO: replace with eww

      libsForQt5.dolphin # Filemanager

      discord
      betterdiscordctl

      #webcord-vencord

      # terminal emulators
      #kitty
      #alacritty

      neovim
      firefox
      tree
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    dotnet-sdk
    brightnessctl # backlight controls
    lshw # a small tool to extract detailed information on the hardware configuration of the machine
    #gcc
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    parted
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

