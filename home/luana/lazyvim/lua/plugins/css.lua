return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				cssls = {
					enabled = true,
				},
			},
		},
	},
	{
		"saghen/blink.cmp",
		opts = {
			sources = {
				providers = {
					lsp = {
						transform_items = function(ctx, items)
							if vim.bo.filetype == "css" then
								-- Stop annoying css property suggestions right after opening a bracket.

								-- Don't show completions if the "word" before the cursor is empty.
								-- i.e. after `{`, whitespace, or a newline.
								if ctx.get_keyword() == "" then
									return {}
								end
							end

							return items
						end,
					},
				},
			},
		},
	},
}
