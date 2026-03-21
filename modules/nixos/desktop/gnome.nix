{
  lib,
  pkgs,
  config,
  ...
}:

{
  config = lib.mkIf config.latte.desktop.gnome.enable {
    services.displayManager.gdm.enable = lib.mkDefault true;
    services.desktopManager.gnome.enable = true;

    services.gnome.core-apps.enable = false;

    environment.gnome.excludePackages = with pkgs; [
      gnome-backgrounds
      gnome-color-manager
      gnome-tour
      gnome-user-docs
    ];

    environment.systemPackages = with pkgs; [
      baobab
      evince # Waiting for papers to get evince's full-featured print dialog
      gnome-calculator
      gnome-calendar
      gnome-system-monitor
      gnome-text-editor
      gnome-tweaks
      gnomeExtensions.appindicator
      nautilus
    ];

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita";
    };
  };
}
