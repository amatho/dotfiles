vim.pack.add({ "https://github.com/RRethy/vim-illuminate" })

require("config.later")(function()
	require("illuminate").configure({
		delay = 100,
		large_file_cutoff = 2000,
		large_file_overrides = {
			providers = { "lsp" },
		},
		min_count_to_highlight = 2,
	})
end)
