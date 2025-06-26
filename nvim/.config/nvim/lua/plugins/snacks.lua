---@module "snacks"

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{
			"<leader>g",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>o",
			function()
				Snacks.picker.files()
			end,
			desc = "Files",
		},
		{
			"<leader>s",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart",
		},
		{
			"<leader>b",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>?",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<M-w>",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete buffer",
		},
	},
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		indent = {
			enabled = true,
			char = "│",
			animate = {
				enabled = false,
			},
		},
		input = { enabled = true },
		picker = {
			enabled = true,
			formatters = {
				file = {
					truncate = 80,
				},
			},
			sources = {
				grep = {
					-- Hide text match from grep result
					transform = function(item)
						item.line = nil
					end,
					hidden = true,
				},
				files = {
					hidden = true,
				},
			},
		},
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
}
