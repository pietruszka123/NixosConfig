{
  config,
  pkgs,
  inputs,
  stable-pkgs,
  hyprland-source,
  zen-browser-source,
  systemModule,
  systemName,
  ...
}@args:
let

  # users =
  #   let
  #     dirs = p: buildins.readDir p;
  #     f = builtins.listToAttrs ( map ( { x, y } @ value: { name = x; inherit value; } ) [...] )
  #   in
  #   dirs ./hosts;

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
      ];
      extraSpecialArgs = {
        inherit inputs;
        inherit stable-pkgs;
        inherit hyprland-source;
        inherit zen-browser-source;
        userName = "test";

        systemConfig = {
          inherit systemModule;
        };
        userConfig = {
          system = {
            specialization = "default";
          };
        };
      };
      users =
        let
          user = userName: {
            ${userName} = import ./hosts/${systemName}/home.nix;
          };
        in
        (user "user");
    };
  };

}
