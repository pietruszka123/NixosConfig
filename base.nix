{
  config,
  pkgs,
  inputs,
  stable-pkgs,
  hyprland-source,
  zen-browser-source,
  systemModule,
  systemName,

  neovim-nightly-overlay-source,
  vicinae-source,
  lib,
  ...
}@args:
let

  users =
    let
      dirs = p: builtins.readDir p;

      f =
        p:
        lib.lists.foldr (
          a: b:
          (
            {
              "${a}" = {
                # _module.args.userName = "user";
                # _module.args.systemBaseVersion = "24.05";
                imports = [
                  (import ./base-user.nix (
                    args
                    // {
                      userName = builtins.trace "${a}" a;
                      systemBaseVersion = config.system.stateVersion;
                    }
                  ))
                ];
              };

            }
            // b
          )
        ) ({ }) (builtins.attrNames (dirs p));
    in
    f ./users;

in
{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  config = {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      sharedModules = [
        inputs.nixcord.homeModules.nixcord
        inputs.vicinae.homeManagerModules.default
        inputs.catppuccin.homeModules.catppuccin
      ];
      extraSpecialArgs = {
        inherit inputs;
        inherit stable-pkgs;
        inherit hyprland-source;
        inherit zen-browser-source;
        inherit neovim-nightly-overlay-source;
        inherit vicinae-source;

        systemConfig = {
          inherit systemModule;
        };
        userConfig = {
          system = {
            specialization = "default";
          };
        };
      };
      users = users;
      # let
      #   user = userName: {
      #     ${userName} = import ./hosts/${systemName}/home.nix;
      #   };
      # in
      # (user "user");

    };
  };

}
