{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:

let
  isDirenvEnabled = config.programs.direnv.enable || osConfig.programs.direnv.enable;
in
{
  programs.vscode = {
    profiles.default.extensions = lib.attrValues lib.mergeAttrsList [
      { inherit (pkgs.vscode-extensions.jnoortheen) nix-ide; }
      (lib.optionalAttrs isDirenvEnabled {
        inherit (pkgs.vscode-extensions.mkhl) direnv;
      })
    ];
  };
}
