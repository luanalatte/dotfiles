{ pkgs, config, ... }:

{
  # Ensure 'vim' points to this neovim and not the system-wide one.
  programs.neovim.vimAlias = true;

  programs.lazyvim = {
    enable = config.latte.profiles.workstation.enable;
    configFiles = ./lua;

    extras = {
      lang = {
        nix.enable = true;
        php.enable = true;
        python.enable = true;
      };
    };

    extraPackages = with pkgs; [
      keep-sorted

      # HTML / CSS
      emmet-language-server
      vscode-css-languageserver

      # nix
      nixd
      nixfmt
      statix

      # PHP
      intelephense
      blade-formatter

      # Python
      basedpyright
      ruff
    ];

    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      blade
    ];
  };
}
