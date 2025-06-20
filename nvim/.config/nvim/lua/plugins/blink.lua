return {
	"saghen/blink.cmp",
	version = "1.*",
	opts = {
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

		appearance = {
			kind_icons = {
				Array = " ",
				Boolean = "󰨙 ",
				Class = " ",
				Codeium = "󰘦 ",
				Color = " ",
				Control = " ",
				Collapsed = " ",
				Constant = "󰏿 ",
				Constructor = " ",
				Copilot = " ",
				Enum = " ",
				EnumMember = " ",
				Event = " ",
				Field = " ",
				File = " ",
				Folder = " ",
				Function = "󰊕 ",
				Interface = " ",
				Key = " ",
				Keyword = " ",
				Method = "󰊕 ",
				Module = " ",
				Namespace = "󰦮 ",
				Null = " ",
				Number = "󰎠 ",
				Object = " ",
				Operator = " ",
				Package = " ",
				Property = " ",
				Reference = " ",
				Snippet = "󱄽 ",
				String = " ",
				Struct = "󰆼 ",
				Supermaven = " ",
				TabNine = "󰏚 ",
				Text = " ",
				TypeParameter = " ",
				Unit = " ",
				Value = " ",
				Variable = "󰀫 ",

				-- Variable = "󰆦",
				-- Constant = "󰏿",
			},
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
	},
	opts_extend = { "sources.default" },
}
