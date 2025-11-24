{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.ghidra;
in
{
  options = {
    modules.ghidra.enable = lib.mkEnableOption "enable ghidra module";
  };
  config = lib.mkIf cfg.enable {

    programs.ghidra = {
      enable = true;
      gdb = true;
    };

  };

}
