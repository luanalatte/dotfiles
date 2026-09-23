{ lib, ... }:

{
  options.latte.desktop = {
    gnome.enable = lib.mkEnableOption "GNOME";
    plasma6.enable = lib.mkEnableOption "KDE Plasma 6";
  };
}
