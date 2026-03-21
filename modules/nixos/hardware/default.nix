{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  imports = [
    ./audio.nix
    ./gpu/nvidia.nix
    ./mouse.nix
  ];

  options.latte.hardware.gpu = mkOption {
    type = types.nullOr (
      types.enum [
        # "intel"
        # "amd"
        "nvidia"
      ]
    );
    default = null;
    description = "The manufacturer of the primary system gpu";
  };
}
