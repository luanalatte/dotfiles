{ lib, config, ... }:

let
  inherit (config.latte.hardware) gpu;
  inherit (lib) mkIf mkDefault;
in
{
  config = mkIf (gpu == "nvidia") {
    services.xserver.videoDrivers = [ "nvidia" ];

    boot = {
      initrd.kernelModules = [ "nvidia" ];
      extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    };

    # TODO: add libva for hardware acceleration

    hardware = {
      graphics.enable = true;

      nvidia = {
        package = mkDefault config.boot.kernelPackages.nvidiaPackages.production;
        open = false;
        modesetting.enable = true;
        powerManagement.enable = true;
        nvidiaSettings = true;
      };
    };
  };
}
