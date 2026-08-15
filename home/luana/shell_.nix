{
  home.shellAliases = {
    ":q" = "exit";
    flake = "nix flake";
  };

  programs = {
    tealdeer = {
      settings.updates = {
        auto_update = true;
        auto_update_interval_hours = 24 * 15; # every 15 days
      };
    };
  };
}
