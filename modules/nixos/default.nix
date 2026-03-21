{ lib, inputs, ... }:

{
  imports = [
    ../base
    ../options
    ./boot
    ./desktop
    ./hardware
    ./users
    ./locale.nix
    inputs.home-manager.nixosModules.default
  ];
}
