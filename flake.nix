{
  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    easy-hosts.url = "github:tgirlcloud/easy-hosts";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ ./hosts ];

      perSystem =
        { pkgs, ... }:
        {
          packages.diff-system = pkgs.writeShellApplication {
            name = "diff-system";
            text = ''
              new=$(
                nix build --no-link --print-out-paths ".#nixosConfigurations.$(hostname).config.system.build.toplevel"
              )

              nix store diff-closures /run/current-system "$new"
              sudo "$new"/bin/switch-to-configuration dry-activate
            '';
          };
        };
    };
}
