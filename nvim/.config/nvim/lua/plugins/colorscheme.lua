return {
	"deparr/tairiki.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tairiki").setup({
			plugins = {
				auto = true,
			},
			highlights = function(hl, c, opts)
				hl["@punctuation.bracket"] = { fg = c.fg }
				hl.SnacksIndent = { fg = c.bg_light3 }
				hl.GitSignsCurrentLineBlame = { fg = c.fg_dark3 }
			end,
		})

		vim.cmd.colorscheme("tairiki-dark")
	end,
}
