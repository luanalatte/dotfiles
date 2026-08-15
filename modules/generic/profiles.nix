{ lib, ... }:

{
  options.latte.profiles = {
    graphical.enable = lib.mkEnableOption "Graphical interface";
    workstation.enable = lib.mkEnableOption "Workstation";
    laptop.enable = lib.mkEnableOption "Laptop";
    server.enable = lib.mkEnableOption "Server";
    gaming.enable = lib.mkEnableOption "Gaming";
  };
}
