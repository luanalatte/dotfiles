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
    browsers.zen-flatpak.enable = true;
    defaultBrowser = "zen-flatpak";
  };

  latte.packages = mergeAttrsList [
    (optionalAttrs profiles.workstation.enable {
      inherit (pkgs)
        # keep-sorted start
        libreoffice-stable
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
