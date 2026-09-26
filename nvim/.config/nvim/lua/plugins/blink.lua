vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

require("config.later")(function()
	require("blink.cmp").setup({
		cmdline = {
			keymap = {
				["<C-k>"] = { "show", "select_prev", "fallback" },
				["<C-j>"] = { "show", "select_next", "fallback" },
				["tab"] = {},
				["<c-tab>"] = {},
			},
		},
		keymap = {
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },

			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },

			["<C-f>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
		},
		completion = {
			menu = {
				border = "rounded",
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
				treesitter_highlighting = true,
				window = {
					max_width = 100,
					border = "rounded",
				},
			},
			accept = {
				auto_brackets = { enabled = false },
			},
		},
		sources = {
			default = { "lsp", "path" },
		},
	})
end)
