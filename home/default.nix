{
  self,
  lib,
  config,
  inputs,
  ...
}:

let
  cfg = config.latte.system.home-manager;
in
{
  config = lib.mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit self inputs; };

      users = lib.genAttrs config.latte.system.users (name: {
        imports = [ ./${name} ];
      });

      sharedModules = [ (self + /modules/home/default.nix) ];
    };
  };
}
