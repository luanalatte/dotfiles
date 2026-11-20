{
  lib,
  inputs,
  pkgsFor,
}:
lib.fixedPoints.makeExtensible (final: {
  mkHost = import ./mkhost.nix { inherit lib inputs pkgsFor; };
})
