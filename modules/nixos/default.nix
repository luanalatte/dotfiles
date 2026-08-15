{ inputs, ... }:

{
  _class = "nixos";

  imports = [
    # keep-sorted start prefix_order=../,../../,./
    ../generic
    ../../home
    ./boot
    ./desktop
    ./environment
    ./hardware
    ./programs
    ./system
    ./users
    inputs.home-manager.nixosModules.default
    inputs.nix-flatpak.nixosModules.nix-flatpak
    # keep-sorted end
  ];
}
