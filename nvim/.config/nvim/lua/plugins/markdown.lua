vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("amatho_render_markdown_setup", { clear = true }),
	pattern = "markdown",
	once = true,
	callback = function()
		require("render-markdown").setup({
			file_types = { "markdown" },
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
		})
	end,
})
