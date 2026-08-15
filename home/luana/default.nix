{ pkgs, ... }:

{
  imports = [
    ./desktop
    ./dev
    ./lazyvim
    ./shell
    ./themes
  ];

  latte.programs = {
    browsers.zen-browser.enable = true;
    defaultBrowser = "zen-browser";
  };

  latte.packages = with pkgs; [
    # keep-sorted start block=yes
    (prismlauncher.override {
      textToSpeechSupport = false;
      jdks = [
        jdk25
        jdk21
        jdk17
        jdk8
      ];
    })
    heroic
    mpv
    obsidian
    opencode
    signal-desktop
    spotify
    tuxedo
    yt-dlp
    # keep-sorted end
  ];

  programs.discord.enable = true;
}
