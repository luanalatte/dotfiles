{
  lib,
  osConfig,
  pkgs,
  ...
}:

{
  programs.direnv = {
    nix-direnv.enable = lib.mkDefault true;
    nix-direnv.package = lib.mkDefault (pkgs.nix-direnv.override { nix = osConfig.nix.package; });
    config = {
      global = {
        warn_timeout = lib.mkDefault 0;
      };
    };
  };
}
