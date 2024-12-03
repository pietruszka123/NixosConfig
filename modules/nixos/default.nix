{ ... }:
{

  imports = [
    ./system
    ./ssh.nix
    ./podman.nix
    ./packages
    ./flatpak.nix
  ];

}
