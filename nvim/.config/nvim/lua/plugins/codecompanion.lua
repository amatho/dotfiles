return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<leader>c", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code Companion" },
	},
	opts = {
		strategies = {
			chat = {
				adapter = {
					name = "copilot",
					model = "claude-sonnet-4",
				},
			},
		},
	},
}
