{ lib, config, ... }:

{
  programs.fastfetch = {
    enable = lib.mkDefault config.programs.hyfetch.enable;
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
}
