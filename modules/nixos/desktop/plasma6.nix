{
  lib,
  pkgs,
  config,
  ...
}:

{
  config = lib.mkIf config.latte.desktop.plasma6.enable {
    services.displayManager.sddm.enable = lib.mkDefault true;
    services.desktopManager.plasma6.enable = true;

    latte.packages = {
      inherit (pkgs)
        plasma-panel-colorizer
        ;
      inherit (pkgs.kdePackages)
        karousel
        partitionmanager
        ;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      kate
      konsole
    ];
  };
}
