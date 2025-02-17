{
  config,
  lib,
  home,
  pkgs,
  stable-pkgs,
  ...
}:

let
  cfg = config.modules.atuin;
in
{
  options = {
    modules.atuin.enable = lib.mkEnableOption "enable atuin module";
  };
  config = lib.mkIf cfg.enable {

    home.file.".config/fish/conf.d/atuin.fish".text = ''
      if status is-interactive
      atuin init fish | source
      end
    '';

    home.packages = [

       stable-pkgs.atuin

    ];

  };

}
