vim.g.lazyvim_php_lsp = "intelephense"
vim.g.lazyvim_python_lsp = "basedpyright"

local tab_sizes = {
  cs = 4,
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    local size = tab_sizes[vim.bo.filetype]
    if size then
      vim.opt_local.tabstop = size
      vim.opt_local.shiftwidth = size
    end
  end,
})
