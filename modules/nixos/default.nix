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
}
