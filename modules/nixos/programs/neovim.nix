{ lib, config, ... }:

{
  config = lib.mkIf config.programs.neovim.enable {
    programs.neovim = {
      defaultEditor = lib.mkDefault true;
      vimAlias = lib.mkDefault true;
      configure = lib.mkDefault {
        customLuaRC = ''
          vim.opt.tabstop = 4
          vim.opt.shiftwidth = 4
          vim.opt.expandtab = true
          vim.opt.softtabstop = 4
          vim.opt.relativenumber = true

          -- Disable arrow keys
          -- vim.keymap.set({ 'n', 'i', 'v' }, '<Up>', '<Nop>')
          -- vim.keymap.set({ 'n', 'i', 'v' }, '<Down>', '<Nop>')
          -- vim.keymap.set({ 'n', 'i', 'v' }, '<Left>', '<Nop>')
          -- vim.keymap.set({ 'n', 'i', 'v' }, '<Right>', '<Nop>')
        '';
      };
    };
  };
}
