{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib) mergeAttrsList optionalAttrs;
in
{
  config = lib.mkIf config.virtualisation.podman.enable {
    latte.packages = mergeAttrsList [
      { inherit (pkgs) podman-compose; }

      (optionalAttrs config.latte.profiles.graphical.enable {
        inherit (pkgs) podman-desktop;
      })
    ];

    virtualisation.podman = {
      dockerCompat = lib.mkDefault true;
      dockerSocket.enable = lib.mkDefault true;
    };
  };
}
