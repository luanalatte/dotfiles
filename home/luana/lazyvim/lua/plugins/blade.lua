return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				blade = { "blade-formatter" },
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = { "blade" },
		},
	},
	{
		"folke/ts-comments.nvim",
		opts = {
			lang = {
				blade = {
					"{{-- %s --}}",
					php_only = "// %s",
				},
				php_only = "// %s",
			},
		},
	},
}
