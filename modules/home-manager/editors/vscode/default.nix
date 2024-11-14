{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.editors.vscode;
in
{
  options = {
    modules.editors.vscode.enable = lib.mkEnableOption "enable vscode module";
  };
  config = lib.mkIf cfg.enable {

    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhsWithPackages (
        ps: with ps; [
          rustup
          zlib
          openssl.dev
          pkg-config
        ]
      );
    };

  };
}
