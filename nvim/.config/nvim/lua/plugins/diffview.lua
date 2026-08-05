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
		"DiffviewMergeFiles",
	},
	opts = {
		enhanced_diff_hl = true,
		view = {
			merge_tool = { layout = "diff4_mixed" },
		},
	},
}
