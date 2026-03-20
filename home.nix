{ config, pkgs, inputs, ... }:

{
  home.shellAliases = {
    ":q" = "exit";
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.kdePackages.breeze;
    name = "Breeze_Light";
    size = 24;
  };

  xresources.properties = {
    "Xcursor.theme" = config.home.pointerCursor.name;
    "Xcursor.size" = toString config.home.pointerCursor.size;
  };

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      # commit.gpgsign = true;
      # gpg.format = "ssh";
      alias = {
        s = "status";
        b = "branch";
        lo = "log --oneline";
        cane = "commit --amend --no-edit";
      };
    };
  };

  programs.starship.enable = true;
  programs.hyfetch.enable = true;

  programs.vscode = {
    enable = true;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];
  };

  home.packages =
    (with pkgs; [
      fastfetch # for hyfetch

      nixfmt

      kdePackages.karousel
      kdePackages.partitionmanager
      plasma-panel-colorizer

      vesktop
      bitwarden-desktop
      telegram-desktop
      signal-desktop
      obsidian
    ])
    ++ ([
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]);

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
