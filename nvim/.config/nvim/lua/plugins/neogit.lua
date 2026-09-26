vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/NeogitOrg/neogit",
})

require("config.later")(function()
	require("neogit").setup({
		integrations = {
			snacks = true,
		},
	})
end)

vim.keymap.set("n", "<leader>hg", "<cmd>Neogit<cr>", { desc = "Neogit" })
