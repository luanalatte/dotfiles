return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			nix = { "nixfmt", "keep-sorted" },
		},
		formatters = {
			["keep-sorted"] = {
				command = "keep-sorted",
				stdin = false,
				args = { "$FILENAME" },
			},
		},
	},
}
