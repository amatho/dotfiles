return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ibhagwan/fzf-lua",
	},
	lazy = true,
	keys = {
		{ "<leader>hg", "<cmd>Neogit<cr>", { desc = "Neogit" } },
	},
	opts = {},
}
