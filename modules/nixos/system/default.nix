{ ... }:
{
  imports = [
    ./nvidia.nix
    ./pipewire.nix
    ./networking.nix
    ./powerManagement.nix
    ./lemurs
    ./greetd.nix
    ./bluetooth.nix
    ./opentabletdriver.nix
  ];

}
