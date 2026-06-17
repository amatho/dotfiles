return {
	"dlyongemallo/diffview-plus.nvim",
	version = "*",
	keys = {
		{ "<Leader>hd", "<cmd>DiffviewToggle<cr>", desc = "Toggle Diffview" },
	},
	cmd = {
		"DiffviewOpen",
		"DiffviewToggle",
		"DiffviewFileHistory",
		"DiffviewDiffFiles",
		"DiffviewLog",
	},
}
