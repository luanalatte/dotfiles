{
  lib,
  inputs,
  pkgs,
  config,
  ...
}:

{
  # Ensure 'vim' points to this neovim and not the system-wide one.
  programs.neovim.vimAlias = true;

  programs.lazyvim = {
    enable = lib.mkDefault config.latte.profiles.workstation.enable;
    configFiles = ./lua;

    extras = {
      lang = {
        dotnet.enable = true;
        nix.enable = true;
        php.enable = true;
        python.enable = true;
        tex.enable = true;
      };
    };

    extraPackages = with pkgs; [
      keep-sorted

      # HTML / CSS
      emmet-language-server
      vscode-css-languageserver

      # dotnet
      csharpier
      omnisharp-roslyn

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

      # LaTeX
      texlab
    ];

    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      blade
    ];

    plugins.colorscheme = inputs.lazyvim.lib.lazyConfig [
      {
        plugin = "folke/tokyonight.nvim";
        enabled = false;
      }
      {
        plugin = "LazyVim";
        opts = {
          colorscheme = "catppuccin-mocha";
        };
      }
    ];
  };
}
