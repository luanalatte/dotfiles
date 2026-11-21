{ lib, config, ... }:

let
  profiles = config.latte.profiles;
in
{
  home.shellAliases = {
    ":q" = "exit";
    flake = "nix flake";
    "t" = "tuxedo";
  };

  programs = {
    # keep-sorted start block=yes
    direnv.enable = profiles.workstation.enable;
    hyfetch.enable = true;
    jq.enable = true;
    starship = {
      enable = profiles.workstation.enable;
      settings = {
        format = lib.concatStrings (
          map (s: "$" + s) [
            "username"
            "hostname"
            "shlvl"
            "directory"
            "git_branch"
            "git_commit"
            "git_state"
            "git_metrics"
            "git_status"
            "docker_context"
            "nix_shell"
            "direnv"
            "sudo"
            "cmd_duration"
            "line_break"
            "jobs"
            "battery"
            "container"
            "character"
          ]
        );
        # keep-sorted start block=yes
        direnv = {
          disabled = false;
          format = "[$symbol$loaded$allowed]($style) ";
          allowed_msg = "";
          not_allowed_msg = "/not allowed";
          denied_msg = "/denied";
        };
        nix_shell = {
          format = "[$symbol$state\\($name\\)]($style) ";
          impure_msg = ""; # direnv "use flake" shells are always impure so this becomes annoying.
          symbol = "󱄅 ";
        };
        shlvl = {
          disabled = false;
          symbol = " ";
        };
        sudo = {
          disabled = false;
          symbol = " ";
        };
        #keep-sorted end
      };
    };
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
