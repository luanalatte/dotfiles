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

    # I don't need NVIDIA HDMI audio device
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{remove}="1"
    '';

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
