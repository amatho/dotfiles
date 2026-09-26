vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })

require("config.later")(function()
	require("nvim-autopairs").setup({})
end)
