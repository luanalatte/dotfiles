{ pkgs, ... }:

{
  home.shellAliases = {
    ":q" = "exit";
  };

  programs.starship.enable = true;
  programs.hyfetch.enable = true;

  programs.tealdeer = {
    enable = true;
    settings.updates = {
      auto_update = true;
      auto_update_interval_hours = 24 * 15; # every 15 days
    };
  };

  home.packages = with pkgs; [
    fastfetch
  ];
}
