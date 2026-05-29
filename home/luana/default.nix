{ pkgs, ... }:

{
  imports = [
    ./desktop
    ./dev
    ./shell
    ./themes
  ];

  latte.programs = {
    browsers.zen-browser.enable = true;
    defaultBrowser = "zen-browser";
  };

  latte.packages = with pkgs; [
    bitwarden-desktop
    heroic
    logseq
    mpv
    obsidian
    (prismlauncher.override {
      textToSpeechSupport = false;
      jdks = [
        jdk25
        jdk21
        jdk17
        jdk8
      ];
    })
    signal-desktop
    spotify
    telegram-desktop
    yt-dlp
  ];

  programs.discord.enable = true;
  programs.vesktop.enable = true;
}
