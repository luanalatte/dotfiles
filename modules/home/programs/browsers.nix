{
  lib,
  config,
  pkgs,
  inputs,
  _class,
  ...
}:

let
  cfg = config.latte.programs;

  enabledBrowsers = lib.filterAttrs (_: b: b.enable) cfg.browsers;
  enabledPackages = lib.mapAttrsToList (_: b: b.package) enabledBrowsers;

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

      zen-browser = {
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
