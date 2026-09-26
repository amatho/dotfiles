vim.pack.add({ "https://github.com/folke/which-key.nvim" })

require("config.later")(function()
	require("which-key").setup({})
end)
