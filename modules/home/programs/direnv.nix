{
  osConfig,
  pkgs,
  ...
}:

{
  programs.direnv = {
    nix-direnv.enable = true;
    nix-direnv.package = pkgs.nix-direnv.override { nix = osConfig.nix.package; };
    config = {
      global = {
        warn_timeout = 0;
      };
    };
  };
}
