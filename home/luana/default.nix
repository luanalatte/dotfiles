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
    vesktop
    bitwarden-desktop
    telegram-desktop
    signal-desktop
    obsidian
  ];
}
