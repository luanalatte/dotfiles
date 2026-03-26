{ lib, config, ... }:

{
  options.latte.system.stateVersion = lib.mkOption {
    internal = true;
    type = lib.types.str;
    default = "25.11";
  };

  config.system.stateVersion = config.latte.system.stateVersion;
}
