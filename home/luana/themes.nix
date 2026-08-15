{ pkgs, inputs, ... }:

{
  home.pointerCursor = {
    enable = true;
    package = pkgs.kdePackages.breeze;
    name = "Breeze_Light";
    size = 24;
  };

  programs.alacritty.theme = "catppuccin_mocha";

  programs.lazyvim.plugins.colorscheme = inputs.lazyvim.lib.lazyConfig [
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
}
