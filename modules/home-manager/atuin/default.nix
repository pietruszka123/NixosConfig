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
#      atuin init fish | source
if type -q atuin
    set -l __atuin_init (atuin init fish | string replace -ra -- 'bind -M ([^ ]+)\s+-k ' 'bind -M $1 ' | string replace -ra -- 'bind\s+-k ' 'bind ')
    if test -n "$__atuin_init"
        printf '%s\n' $__atuin_init | source
        if functions -q _atuin_bind_up
            bind up _atuin_bind_up
            bind -M insert up _atuin_bind_up
        end
    else
        # fallback: source unmodified but silence deprecation noise
        atuin init fish 2>/dev/null | source
    end
end
      end
    '';

    home.packages = [
       pkgs.atuin
    ];

  };

}
