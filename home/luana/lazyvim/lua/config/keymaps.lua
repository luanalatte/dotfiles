-- User keymaps configured via Nix
local map = vim.keymap.set
local unmap = vim.keymap.del

-- Toggle terminal
unmap({ "n", "t" }, "<C-/>")
unmap({ "n", "t" }, "<C-_>")
map({ "n", "t" }, "<c-`>", function()
	Snacks.terminal.focus(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })
