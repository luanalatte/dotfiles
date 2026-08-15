{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib) mergeAttrsList optionalAttrs;

  profiles = config.latte.profiles;
in
{
  latte.programs = {
    browsers.zen-browser.enable = true;
    defaultBrowser = "zen-browser";
  };

  latte.packages = mergeAttrsList [
    (optionalAttrs profiles.workstation.enable {
      inherit (pkgs)
        # keep-sorted start
        libreoffice-still
        opencode
        tuxedo
        # keep-sorted end
        ;
    })

    (optionalAttrs profiles.graphical.enable {
      inherit (pkgs)
        # keep-sorted start
        mpv
        obsidian
        signal-desktop
        spotify
        yt-dlp
        # keep-sorted end
        ;
    })

    (optionalAttrs profiles.gaming.enable {
      inherit (pkgs)
        heroic
        ;
    })
  ];
}
