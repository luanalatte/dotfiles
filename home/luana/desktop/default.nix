{ config, pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;
    package = pkgs.kdePackages.breeze;
    name = "Breeze_Light";
    size = 24;
  };

  xresources.properties = {
    "Xcursor.theme" = config.home.pointerCursor.name;
    "Xcursor.size" = toString config.home.pointerCursor.size;
  };

  home.packages = with pkgs; [
    kdePackages.karousel
    kdePackages.partitionmanager
    plasma-panel-colorizer
  ];
}
