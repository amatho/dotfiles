-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
-- used for completion, annotations and signatures of Neovim apis
vim.pack.add({ "https://github.com/folke/lazydev.nvim" })

require("config.later")(function()
	require("lazydev").setup({
		library = {
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	})
end)
