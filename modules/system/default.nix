{ ... }: {
  imports = [
    ./nvidia.nix
    ./pipewire.nix
    ./networking.nix
    ./powerManagement.nix
    ./lemurs.nix
  ];

}
