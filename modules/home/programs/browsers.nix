{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.latte.programs;

  enabledBrowsers = lib.filterAttrs (_: b: b.enable) cfg.browsers;
  enabledPackages = lib.mapAttrs (_: b: b.package) (
    lib.filterAttrs (_: b: b.package or null != null) enabledBrowsers
  );

  defaultBrowser = if cfg.defaultBrowser != null then enabledBrowsers.${cfg.defaultBrowser} else null;

  inherit (lib.types)
    enum
    nullOr
    package
    str
    ;
in
{
  options.latte.programs = {
    browsers = {
      firefox = {
        enable = lib.mkEnableOption "Firefox";
        package = lib.mkPackageOption pkgs "firefox" { };
        desktopFileName = lib.mkOption {
          type = str;
          default = "firefox.desktop";
        };
      };

      zen = {
        enable = lib.mkEnableOption "Zen Browser";
        package = lib.mkOption {
          type = package;
          default = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };
        desktopFileName = lib.mkOption {
          type = str;
          default = "zen.desktop";
        };
      };

      zen-flatpak = {
        enable = lib.mkEnableOption "Zen Browser (Flatpak)";
        desktopFileName = lib.mkOption {
          type = str;
          default = "app.zen_browser.zen.desktop";
        };
      };
    };

    defaultBrowser = lib.mkOption {
      type = nullOr (enum (builtins.attrNames cfg.browsers));
      default = null;
      description = "The default web browser to use.";
    };
  };

  config = {
    latte.packages = enabledPackages;

    xdg.mimeApps = lib.mkIf (defaultBrowser != null) {
      enable = lib.mkDefault true;
      defaultApplications = {
        "text/html" = defaultBrowser.desktopFileName;
        "x-scheme-handler/http" = defaultBrowser.desktopFileName;
        "x-scheme-handler/https" = defaultBrowser.desktopFileName;
      };
    };
  };
}
