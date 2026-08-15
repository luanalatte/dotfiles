{ config, ... }:

let
  profiles = config.latte.profiles;
in
{
  home.shellAliases = {
    ":q" = "exit";
    flake = "nix flake";
  };

  programs = {
    # keep-sorted start block=yes
    direnv.enable = profiles.workstation.enable;
    hyfetch.enable = true;
    starship.enable = profiles.workstation.enable;
    tealdeer = {
      enable = true;
      settings.updates = {
        auto_update = true;
        auto_update_interval_hours = 24 * 15; # every 15 days
      };
    };
    # keep-sorted end
  };
}
