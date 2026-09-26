vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })

require("config.later")(function()
	require("copilot").setup({
		suggestion = {
			auto_trigger = true,
			keymap = {
				accept = "<Tab>",
			},
		},
	})
end)
