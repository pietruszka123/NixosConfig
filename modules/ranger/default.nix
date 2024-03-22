{ config, lib, pkgs, ... }:

let cfg = config.modules.ranger;
in {
  options = {
    modules.ranger.enable = lib.mkEnableOption "enable ranger module";
  };
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [ ranger ];
  };

}
