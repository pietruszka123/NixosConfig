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
    ./openvpn.nix
    ./opentabletdriver.nix
  ];

}
