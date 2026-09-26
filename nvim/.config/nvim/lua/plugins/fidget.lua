vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })

require("config.later")(function()
	require("fidget").setup({})
end)
