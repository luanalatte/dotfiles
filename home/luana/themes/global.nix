{ pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;
    package = pkgs.kdePackages.breeze;
    name = "Breeze_Light";
    size = 24;
  };
}
