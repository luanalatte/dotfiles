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

    lazyvim.url = "github:pfassina/lazyvim-nix";
    lazyvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, ... }:
      {
        systems = [ "x86_64-linux" ];
        imports = [
          ./hosts
          inputs.home-manager.flakeModules.default
        ];

        flake.homeModules.default = ./modules/home;
        flake.homeConfigurations.luana = withSystem "x86_64-linux" (
          { pkgs, ... }:
          inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            extraSpecialArgs = {
              inherit inputs;
              inherit (inputs) self;
            };

            modules = [
              ./home/luana/lazyvim
              inputs.self.homeModules.default
              {
                home.username = "luana";
                home.homeDirectory = "/home/luana";
                nixpkgs.config.allowUnfree = true;

                programs.lazyvim.enable = true;
              }
            ];
          }
        );

        perSystem =
          { pkgs, ... }:
          {

            devShells.default = pkgs.mkShellNoCC {
              packages = with pkgs; [
                lua-language-server
                stylua
                writeShellApplication
                {
                  name = "diff-system";
                  text = ''
                    new=$(
                      nix build --no-link --print-out-paths ".#nixosConfigurations.$(hostname).config.system.build.toplevel"
                    )

                    nix store diff-closures /run/current-system "$new"
                    sudo "$new"/bin/switch-to-configuration dry-activate
                  '';
                }
              ];
            };
          };
      }
    );
}
