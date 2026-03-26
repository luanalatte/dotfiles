{
  lib,
  config,
  _class,
  ...
}:

let
  inherit (lib) mergeAttrsList optionalAttrs;
  inherit (lib.types) listOf package;
in
{
  # using attrsOf instead of listOf package would allow things like wrapper packages easily, which I'm not using rn.

  options.latte.packages = lib.mkOption {
    type = listOf package;
    default = { };
    description = "Additional packages to be installed in the current environment (homeManager or nixos).";
  };

  config = mergeAttrsList [
    (optionalAttrs (_class == "nixos") {
      environment.systemPackages = config.latte.packages;
      # environment.systemPackages = builtins.attrValues config.latte.packages;
    })

    (optionalAttrs (_class == "homeManager") {
      home.packages = config.latte.packages;
      # home.packages = builtins.attrValues config.latte.packages;
    })
  ];
}
