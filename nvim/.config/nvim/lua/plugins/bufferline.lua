return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	keys = {
		{ "gn", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" } },
		{ "gp", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" } },
		{ "<M-,>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" } },
		{ "<A-.>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" } },
	},
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count)
				return "(" .. count .. ")"
			end,
			truncate_names = false,
			show_buffer_close_icons = false,
			close_icon = "",
			offsets = {
				{
					filetype = "neo-tree",
					highlight = "NeoTreeNormal",
					text_align = "left",
					-- Not showing the separator removes an awkward gap between neotree and the first buffer
					-- separator = "▏",
				},
			},
		},
	},
}
