{ pkgs, ... }:

{
  imports = [
    ./browser.nix
    ./desktop
    ./dev
    ./shell
    ./themes
  ];

  home.packages = with pkgs; [
    vesktop
    bitwarden-desktop
    telegram-desktop
    signal-desktop
    obsidian
  ];
}
