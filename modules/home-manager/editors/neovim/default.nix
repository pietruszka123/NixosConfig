{
  config,
  lib,
  pkgs,
  neovim-nightly-overlay-source,
  ...
}:

let
  cfg = config.modules.editors.neovim;

in
{
  options = {
    modules.editors.neovim.enable = lib.mkEnableOption "enable neovim module";
    modules.editors.neovim.default_editor = lib.mkEnableOption {
      description = "set neovim as default editor";
      default = true;
    };
  };
  config = lib.mkIf cfg.enable {

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      withPython3 = true;
      package =  neovim-nightly-overlay-source.default;
    };

    # environment.variables =
    #   if (cfg.default_editor == true) then
    #     {
    #       EDITOR = "nvim";
    #     }
    #   else
    #     {
    #     };

    home.packages = with pkgs; [
      python3

      nil

      nixd

      lua-language-server
      ripgrep
      taplo-lsp
    ];

  };

}
