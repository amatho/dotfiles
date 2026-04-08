return {
	"kylechui/nvim-surround",
	event = "BufEnter",
	opts = {
		surrounds = {
			["("] = {
				add = { "(", ")" },
				delete = "^(.)().-(.)()$",
			},
			["{"] = {
				add = { "{", "}" },
				delete = "^(.)().-(.)()$",
			},
			["<"] = {
				add = { "<", ">" },
				delete = "^(.)().-(.)()$",
			},
			["["] = {
				add = { "[", "]" },
				delete = "^(.)().-(.)()$",
			},
		},
	},
}
