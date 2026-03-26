{ pkgs, ... }:

{
  imports = [
    ./browser.nix
    ./desktop
    ./dev
    ./shell
    ./themes
  ];

  latte.packages = with pkgs; [
    vesktop
    bitwarden-desktop
    telegram-desktop
    signal-desktop
    obsidian
  ];
}
