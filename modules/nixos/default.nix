{ lib, inputs, ... }:

{
  _class = "nixos";

  imports = [
    ../../home
    ../options
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
