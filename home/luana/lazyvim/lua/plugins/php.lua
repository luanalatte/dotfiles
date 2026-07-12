return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				intelephense = { enabled = true },
				phpactor = { enabled = false },
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				php = { "pint" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = "LazyFile",
		opts = {
			linters_by_ft = {
				php = {}, -- Disable phpcs, since we're using pint.
			},
		},
	},
}
