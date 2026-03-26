{ lib, ... }:

{
  options.latte.profiles = {
    graphical.enable = lib.mkEnableOption "Graphical interface";
    laptop.enable = lib.mkEnableOption "Laptop";
    server.enable = lib.mkEnableOption "Server";
  };
}
