{
  lib,
  pkgs,
  config,
  ...
}:

let
  cfg = config.latte.hardware.printers;
in
{
  options.latte.hardware.printers = {
    epsonL3150 = {
      enable = lib.mkEnableOption "Epson L3150 printer";
    };
  };

  config = {
    latte.packages = (lib.mkIf (cfg.epsonL3150.enable) [ pkgs.epson-escpr ]);

    services.printing.enable = lib.mkIf (cfg.epsonL3150.enable) true;
  };
}
