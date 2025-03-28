return {
	"projekt0n/github-nvim-theme",
	name = "github-theme",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function(opts)
		local color = require("github-theme.lib.color")
		local spec = require("github-theme.spec").load("github_dark")
		local fg = color(spec.bg1):blend(color(spec.fg1), 0.1):to_css()
		local cyan_fg = color(spec.bg1):blend(color(spec.palette.cyan.bright), 0.35):to_css()

		require("github-theme").setup({
			groups = {
				all = {
					SnacksIndent = { fg = fg },
					SnacksIndentScope = { fg = cyan_fg },
				},
			},
		})

		vim.cmd("colorscheme github_dark")
	end,
}
