{ pkgs, inputs, ... }:

{
  latte.packages = [ inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default ];

  xdg.mimeApps.defaultApplications = {
    "text/html" = "zen.desktop";
    "x-scheme-handler/http" = "zen.desktop";
    "x-scheme-handler/https" = "zen.desktop";
  };
}
