{ pkgs, ... }:

{
  home.shellAliases = {
    ":q" = "exit";
    flake = "nix flake";
  };

  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.hyfetch.enable = true;

  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "packages"
        "de"
        "wm"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "localip"
        "battery"
        "poweradapter"
        "break"
        "colors"
      ];
    };
  };

  programs.tealdeer = {
    enable = true;
    settings.updates = {
      auto_update = true;
      auto_update_interval_hours = 24 * 15; # every 15 days
    };
  };
}
