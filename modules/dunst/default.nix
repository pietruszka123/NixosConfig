{ config, lib, pkgs, ... }:

let cfg = config.modules.dunst;
in {
  options = {
    modules.dunst.enable = lib.mkEnableOption "enable dunst module";
  };
  config = lib.mkIf cfg.enable {

      home.packages = with pkgs; [
        dunst
      ];

  };

}
