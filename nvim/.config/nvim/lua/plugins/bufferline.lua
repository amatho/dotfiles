vim.pack.add({ "https://github.com/akinsho/bufferline.nvim" })

require("config.later")(function()
	require("bufferline").setup({
		options = {
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count)
				return "(" .. count .. ")"
			end,
			truncate_names = false,
			show_buffer_close_icons = false,
			close_icon = "",
			offsets = {
				{
					filetype = "neo-tree",
					highlight = "NeoTreeNormal",
					text_align = "left",
					-- Not showing the separator removes an awkward gap between neotree and the first buffer
					-- separator = "▏",
				},
			},
		},
	})
end)

vim.keymap.set("n", "gn", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "gp", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<M-,>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<A-.>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
