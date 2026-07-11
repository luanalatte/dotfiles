{ pkgs, ... }:

{
  # Ensure 'vim' points to this neovim and not the system-wide one.
  programs.neovim.vimAlias = true;

  programs.lazyvim = {
    enable = true;
    configFiles = ./lua;

    extras = {
      lang.nix.enable = true;
      lang.php.enable = true;
    };

    extraPackages = with pkgs; [
      # Lua
      lua-language-server
      stylua

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
    ];

    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      blade
    ];
  };
}
