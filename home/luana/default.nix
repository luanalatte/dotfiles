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
    heroic
    mpv
    obsidian
    opencode
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
    tuxedo
    yt-dlp
  ];

  programs.discord.enable = true;
}
