{ lib, ... }:

{
  options.latte.system.stateVersion = lib.mkOption {
    internal = true;
    type = lib.types.str;
    default = "25.11";
  };
}
