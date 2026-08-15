{
  lib,
  pkgs,
  config,
  ...
}:

let
  cfg = config.latte.hardware;
in
{
  options.latte.hardware.nvidia = {
    hdmiAudio = lib.mkEnableOption "NVIDIA HDMI audio" // {
      default = true;
    };
  };

  config = lib.mkIf (cfg.gpu == "nvidia") {
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

    services.udev.extraRules = lib.mkIf (cfg.nvidia.hdmiAudio == false) ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{remove}="1"
    ''; # NVIDIA HDMI audio device
  };
}
