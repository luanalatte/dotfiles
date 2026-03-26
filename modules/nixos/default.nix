{ lib, inputs, ... }:

{
  _class = "nixos";

  imports = [
    ../../home
    ../generic
    ./boot
    ./desktop
    ./hardware
    ./locale.nix
    ./nix.nix
    ./revision.nix
    ./users
    inputs.home-manager.nixosModules.default
  ];
}
