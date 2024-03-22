{ config, lib, ... }:

let cfg = config.modules.fish;
in {
  options = { modules.fish.enable = lib.mkEnableOption "enable Fish module"; };
  config = lib.mkIf cfg.enable {

    home.file.".config/fish/config.fish".source = ./config.fish;

  };

}
