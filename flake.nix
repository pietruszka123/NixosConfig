{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    hyprland.url = "github:hyprwm/Hyprland";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    nixcord = {
      url = "github:kaylorben/nixcord";
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
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      stable-pkgs = nixpkgs-stable.legacyPackages.${system};
      hyprland-source = hyprland.packages.${system};
      zen-browser-source = zen-browser.packages.${system};

    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit stable-pkgs;
            inherit hyprland-source;
            inherit zen-browser-source;
          };
          modules = [ ./hosts/laptop ];
        };
        laptop2 = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit stable-pkgs;
            inherit hyprland-source;
            inherit zen-browser-source;
          };
          modules = [ ./hosts/laptop2 ];
        };

        pc = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit stable-pkgs;
            inherit hyprland-source;
            inherit zen-browser-source;
          };
          modules = [ ./hosts/pc ];
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          nil
          hyprls
          nixfmt-rfc-style

        ];

      };

    };
}
