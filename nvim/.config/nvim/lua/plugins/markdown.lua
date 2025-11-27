return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	ft = { "markdown", "codecompanion" },
	opts = {
		file_types = { "markdown", "codecompanion" },
		overrides = {
			buftype = {
				nofile = {
					render_modes = { "n", "c", "i" },
					debounce = 5,
					-- code = {
					-- 	left_pad = 0,
					-- 	right_pad = 0,
					-- 	language_pad = 0,
					-- },
				},
			},
		},
	},
}
