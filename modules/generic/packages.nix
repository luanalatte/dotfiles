{
  lib,
  config,
  _class,
  ...
}:

let
  inherit (lib.types) lazyAttrsOf package;
in
{
  options.latte.packages = lib.mkOption {
    type = lazyAttrsOf package;
    default = { };
    description = "A set of packages to install in the current environment (homeManager or nixos).";
  };

  config =
    if _class == "homeManager" then
      { home.packages = builtins.attrValues config.latte.packages; }
    else
      { environment.systemPackages = builtins.attrValues config.latte.packages; };
}
