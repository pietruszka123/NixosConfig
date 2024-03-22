{ lib, config, ... }: {
  options.modules.packages = {
    enable = lib.mkEnableOption "enable packages module";
  };

  config = lib.mkIf config.modules.packages.enable { };
}
