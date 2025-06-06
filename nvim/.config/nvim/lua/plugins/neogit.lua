return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	lazy = true,
	keys = {
		{ "<leader>hg", "<cmd>Neogit<cr>", { desc = "Neogit" } },
	},
	opts = {
		integrations = {
			snacks = true,
		},
	},
}
