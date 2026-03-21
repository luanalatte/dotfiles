{ lib, inputs, ... }:

{
  imports = [
    ../base
    ../options
    ./boot
    ./hardware
    ./users
    ./locale.nix
    inputs.home-manager.nixosModules.default
  ];

  # https://nixos.org/manual/nixos/unstable/release-notes.html
  system.stateVersion = lib.mkDefault "25.11";
}
