{ pkgs, inputs, ... }:

let
  lazyConfig = inputs.lazyvim.lib.lazyConfig;
in
{
  # Ensure 'vim' points to this neovim and not the system-wide one.
  programs.neovim.vimAlias = true;

  programs.lazyvim = {
    enable = true;

    extras = {
      lang.nix.enable = true;
      lang.php.enable = true;
    };

    extraPackages = with pkgs; [
      # nix
      nixd
      nixfmt
      statix

      # PHP
      intelephense
      php.packages.php-codesniffer
      php.packages.php-cs-fixer
    ];

    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      blade
    ];

    config = {
      options = lazyConfig {
        vim.g.lazyvim_php_lsp = "intelephense";
      };
      keymaps = ''
        local map = vim.keymap.set
        local unmap = vim.keymap.del

        -- Toggle terminal
        unmap({"n","t"}, "<C-/>")
        unmap({"n","t"}, "<C-_>")
        map({"n","t"}, "<c-`>",function() Snacks.terminal.focus(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
      '';
    };

    plugins = {
      nix = lazyConfig {
        plugin = "neovim/nvim-lspconfig";
        opts.servers = {
          nil_ls = false;
          nixd = { };
        };
      };
      colorscheme = lazyConfig [
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
  };
}
