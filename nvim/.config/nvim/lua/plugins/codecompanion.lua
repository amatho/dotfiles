return {
	"olimorris/codecompanion.nvim",
	keys = {
		{ "<leader>c", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code Companion" },
	},
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
}
