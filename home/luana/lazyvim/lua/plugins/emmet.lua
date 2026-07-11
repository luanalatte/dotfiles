return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			emmet_ls = {
				enabled = false,
			},
			emmet_language_server = {
				enabled = true,
				filetypes = {
					"astro",
					"blade",
					"css",
					"eruby",
					"html",
					"htmlangular",
					"htmldjango",
					"javascriptreact",
					"less",
					"pug",
					"sass",
					"scss",
					"svelte",
					"templ",
					"typescriptreact",
					"vue",
				},
			},
		},
	},
}
