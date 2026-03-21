{ lib, ... }:

let
  inherit (lib.types) str;
in
{
  # https://nixos.org/manual/nixos/unstable/release-notes.html

  options.latte.system.stateVersion = lib.mkOption {
    internal = true;
    type = str;
    default = "25.11";
  };
}
