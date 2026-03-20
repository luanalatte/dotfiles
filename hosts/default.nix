{ self, inputs, ... }:

{
  imports = [ inputs.easy-hosts.flakeModule ];

  config.easy-hosts = {
    shared = {
      modules = [ ];
      specialArgs = { };
    };

    perClass = class: {
      modules = [
        "${self}/modules/${class}/default.nix"
      ];
    };

    hosts.desktop = {
      arch = "x86_64";
      class = "nixos";
      modules = [ ];
    };
  };
}
