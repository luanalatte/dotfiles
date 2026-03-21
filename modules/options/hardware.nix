{ lib, ... }:

let
  inherit (lib.types) enum nullOr;
in
{
  options.latte.hardware.gpu = lib.mkOption {
    type = nullOr (enum [
      # "intel"
      # "amd"
      "nvidia"
    ]);
    default = null;
    description = "The manufacturer of the primary system gpu";
  };
}
