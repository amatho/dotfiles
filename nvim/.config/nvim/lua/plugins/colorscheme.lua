vim.pack.add({ "https://github.com/deparr/tairiki.nvim" })

require("tairiki").setup({
	transparent = true,
	plugins = {
		blink = true,
		gitsigns = true,
		neotree = true,
		which_key = true,
	},
	highlights = function(hl, c, opts)
		hl["@punctuation.bracket"] = { fg = c.fg }
		hl.SnacksIndent = { fg = c.bg_light3 }
		hl.GitSignsCurrentLineBlame = { fg = c.fg_dark3 }
	end,
})

vim.cmd.colorscheme("tairiki-dark")
