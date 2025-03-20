{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.browsers.zen;

  mkFirefoxModule = import ./home-manager/mkFirefoxModule.nix;

  modulePath = [
    "programs"
    "zen"
  ];
in
{

  imports = [
    (mkFirefoxModule {
      inherit modulePath;
      name = "Zen";
      wrappedPackageName = "default";
      unwrappedPackageName = "twilight";
      visible = true;

      platforms.linux = {
        configPath = ".zen";
        vendorPath = ".zen";
      };

    })

  ];

}
