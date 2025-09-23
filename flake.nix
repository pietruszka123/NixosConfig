{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";

    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # caelestia-shell = {
    #   url = "github:caelestia-dots/shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # caelestia-cli = {
    #   url = "github:caelestia-dots/cli";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #
    # };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      catppuccin,
      hyprland,
      zen-browser,
      neovim-nightly-overlay,
      # caelestia-shell,
      # caelestia-cli,
      vicinae,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      stable-pkgs = nixpkgs-stable.legacyPackages.${system};
      hyprland-source = hyprland.packages.${system};
      zen-browser-source = zen-browser.packages.${system};
      neovim-nightly-overlay-source = inputs.neovim-nightly-overlay.packages.${system};
	  vicinae-source = inputs.vicinae.packages.${system};
      # caelestia-shell-source = caelestia-shell.packages.${system};
      # caelestia-cli-source = caelestia-cli.packages.${system};
    in
    {
      nixosConfigurations =
        let
          system = systemName: {
            ${systemName} = nixpkgs.lib.nixosSystem {

              specialArgs = {
                inherit systemName;
                inherit inputs;
                inherit stable-pkgs;
                inherit hyprland-source;
                inherit zen-browser-source;
                inherit neovim-nightly-overlay-source;
				inherit vicinae-source;
                # inherit caelestia-shell-source;
                # inherit caelestia-cli-source;
              };
              modules = [ ./hosts/${systemName} ];

            };
          };
        in
        (system "pc") // (system "laptop2");

      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          nil
          hyprls
          nixfmt-rfc-style

        ];

      };

    };
}
