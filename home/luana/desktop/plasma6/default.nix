{
  lib,
  pkgs,
  osConfig,
  ...
}:

{
  config = lib.mkIf osConfig.services.desktopManager.plasma6.enable {
    home.packages = with pkgs; [
      kdePackages.karousel
      kdePackages.partitionmanager
      plasma-panel-colorizer
    ];
  };
}
