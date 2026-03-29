{
  lib,
  pkgs,
  config,
  ...
}:

let
  cfg = config.latte.hardware;

  inherit (config.latte.hardware) gpu;
in
{
  config = lib.mkIf (gpu == "nvidia") {
    services.xserver.videoDrivers = [ "nvidia" ];

    boot = {
      kernelModules = [ "nvidia" ];
      extraModulePackages = [ config.hardware.nvidia.package ];
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";

      GBM_BACKEND = "nvidia-drm";
      NVD_BACKEND = "direct";

      # MOZ_DRM_DEVICE = "/dev/dri/card1";
    };

    environment.systemPackages = with pkgs; [
      libva
      # libva-utils
      # nvtopPackages.nvidia
      # vulkan-tools
    ];

    hardware = {
      graphics = {
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
        ];

        extraPackages32 = with pkgs; [
          pkgsi686Linux.nvidia-vaapi-driver
        ];
      };

      nvidia = {
        package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.production;
        open = false;
        modesetting.enable = true;
        powerManagement.enable = config.systemd.targets.suspend.enable;
        nvidiaSettings = false;
      };
    };
  };
}
