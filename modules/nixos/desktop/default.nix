{ lib, ... }:

{
  imports = [
    ./gnome.nix
    ./plasma6.nix
  ];

  options.latte.desktop = {
    gnome.enable = lib.mkEnableOption "GNOME";
    plasma6.enable = lib.mkEnableOption "KDE Plasma 6";
  };
}
