{ ... }:
{

  imports = [
    ./system
    ./ssh.nix
    ./podman.nix
    ./packages
    ./flatpak.nix
    ./waydroid.nix
    ./virt-manager.nix
	./gnome-keyring.nix
	./ghidra.nix
  ];

}
