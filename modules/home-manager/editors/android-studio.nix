{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.editors.android-studio;
in
{
  options = {
    modules.editors.android-studio.enable = lib.mkEnableOption "enable android-studio module";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ android-studio ];
  };

}
