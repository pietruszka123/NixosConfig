{ config, lib, pkgs, ... }:

let cfg = config.modules.template;
in {
  options = {
    modules.template.enable = lib.mkEnableOption "enable template module";
  };
  config = lib.mkIf cfg.enable { };

}
