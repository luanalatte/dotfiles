{
  lib,
  pkgs,
  config,
  ...
}:

{
  config = lib.mkIf config.virtualisation.podman.enable {
    environment.systemPackages = [
      pkgs.podman-compose
    ]
    ++ lib.optionals config.latte.profiles.graphical.enable [
      pkgs.podman-desktop
    ];

    virtualisation.podman = {
      dockerCompat = lib.mkDefault true;
      dockerSocket.enable = lib.mkDefault true;
    };
  };
}
