return {
	"Shatur/neovim-ayu",
	lazy = false,
	priority = 1000,
	config = function()
		local ayu = require("ayu")
		ayu.setup({
			mirage = true,
		})
		ayu.colorscheme()
	end,
}
