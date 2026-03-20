{ lib, ... }:

{
  imports = [
    ../base
    ../options
  ];

  # https://nixos.org/manual/nixos/unstable/release-notes.html
  system.stateVersion = lib.mkDefault "25.11";
}
