{
  lib,
  inputs,
  pkgsFor,
}:
let
  inherit (inputs) self;
  inherit (lib.attrsets) mapAttrs;
in
name:
{
  arch ? "x86_64",
  class ? "nixos",
}:
let
  inherit (inputs) nixpkgs;

  os =
    {
      iso = "linux";
      nixos = "linux";
    }
    .${class} or class;

  system = "${arch}-${os}";

  inputs' = mapAttrs (_: mapAttrs (_: v: v.${system} or v)) inputs;
in
nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit inputs self;
  };

  modules = [
    "${self}/hosts/${name}/default.nix"

    "${self}/modules/${class}/default.nix"

    {
      key = "dotfiles#specialArgs";
      _file = "${__curPos.file}";

      _module.args = {
        inherit inputs';
        self' = inputs'.self;
      };
    }

    {
      key = "dotfiles#hostname";
      _file = "${__curPos.file}";

      networking.hostName = name;
    }

    {
      key = "dotfiles#nixpkgs";
      _file = "${__curPos.file}";

      nixpkgs.pkgs = pkgsFor.${system};
    }

    nixpkgs.nixosModules.readOnlyPkgs
  ];
}
