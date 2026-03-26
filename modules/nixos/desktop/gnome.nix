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

    services.colord.enable = false; # I don't use color management
    services.geoclue2.enable = false;

    services.gnome = {
      core-apps.enable = true;
      gnome-browser-connector.enable = false; # Not implemented for zen-browser
      gnome-initial-setup.enable = false;
      gnome-online-accounts.enable = false;
      gnome-remote-desktop.enable = false;
      gnome-user-share.enable = false;
      rygel.enable = false;
    };

    environment.gnome.excludePackages = with pkgs; [
      # from core-shell
      gnome-backgrounds
      gnome-color-manager # I don't use color management
      gnome-tour
      gnome-user-docs
      orca # I don't need a screen reader

      # from core-apps
      decibels
      epiphany
      geary
      gnome-characters
      gnome-clocks
      gnome-connections
      gnome-console
      gnome-contacts
      gnome-font-viewer
      gnome-logs
      gnome-maps
      gnome-music
      gnome-software
      gnome-weather
      loupe
      papers
      showtime
      simple-scan
      snapshot
      yelp
    ];

    environment.systemPackages = with pkgs; [
      # baobab
      evince # Waiting for papers to get evince's full-featured print dialog
      # gnome-calculator
      # gnome-calendar
      # gnome-system-monitor
      # gnome-text-editor
      gnome-tweaks
      gnomeExtensions.appindicator
      # nautilus
    ];

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita";
    };
  };
}
