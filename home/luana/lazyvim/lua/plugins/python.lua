return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				basedpyright = {
					handlers = {
						["$/progress"] = function(err, result, ctx)
							-- Only allow the notification to pass if it's the final/initial token,
							-- skipping the flood of empty incremental typing updates
							if result.token == (vim.g.pyright_progress_token or result.token) then
								vim.g.pyright_progress_token = result.token
								vim.lsp.handlers["$/progress"](err, result, ctx)
							end
						end,
					},
				},
			},
		},
	},
}
