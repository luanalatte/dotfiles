{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    lazyvim.url = "github:pfassina/lazyvim-nix";
    lazyvim.inputs.nixpkgs.follows = "nixpkgs";

    vice.url = "github:splitshotz/Vice";
    vice.inputs.nixpkgs.follows = "nixpkgs";

    lerd.url = "github:lerd-env/lerd-nixos";
    lerd.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      inherit (lib.attrsets) mapAttrs;

      # one nixpkgs per system, shared by every host and every output below, so
      # nothing gets evaluated on a second instance
      pkgsFor = lib.attrsets.genAttrs lib.systems.flakeExposed (
        system:
        import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            allowUnsupportedSystem = false;
            allowAliases = false;
          };
          overlays = [
            (import ./overlays.nix)
            inputs.vice.overlays.default
          ];
        }
      );

      forAllSystems = fn: mapAttrs (_: fn) pkgsFor;
    in
    {
      lib = import ./lib { inherit lib inputs pkgsFor; };

      nixosConfigurations = mapAttrs self.lib.mkHost {
        nixos = { };
      };

      homeModules.default = ./modules/home;
      homeConfigurations.luana = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = { inherit inputs self; };
        modules = [
          ./home/luana/lazyvim
          self.homeModules.default
          {
            home.username = "luana";
            home.homeDirectory = "/home/luana";
            programs.lazyvim.enable = true;
          }
        ];
      };

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            lua-language-server
            stylua
            (writeShellApplication {
              name = "diff-system";
              runtimeInputs = [
                nvd
                diffutils
              ];
              text = ''
                new=$(
                  nix build --no-link --print-out-paths \
                    ".#nixosConfigurations.$(hostname).config.system.build.toplevel"
                )

                echo "=== Package changes ==="
                nvd diff /run/current-system "$new"

                # echo
                # echo "=== /etc changes ==="
                # diff -ru --color=auto /run/current-system/etc "$new/etc" || true

                echo
                echo "=== Activation (dry run) ==="
                sudo "$new"/bin/switch-to-configuration dry-activate 2>&1 \
                  | grep -Ev "^warning: would not apply UID change of user ‘gdm-greeter" || true
              '';
            })
          ];
        };
      });
    };
}
