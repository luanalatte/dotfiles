{ lib, config, ... }:

let
  cfg = config.latte.system;
in
{
  # https://nixos.org/manual/nixos/unstable/release-notes.html

  options.latte.system.stateVersion = lib.mkOption {
    internal = true;
    type = lib.types.str;
    default = "25.11";
  };

  config.system.stateVersion = cfg.stateVersion;
}
