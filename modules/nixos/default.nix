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
    ./programs
    ./revision.nix
    ./system
    ./users
    # inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.home-manager.nixosModules.default
  ];
}
