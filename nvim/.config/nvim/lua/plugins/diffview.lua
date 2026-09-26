vim.pack.add({ "https://github.com/dlyongemallo/diffview-plus.nvim" }, { load = function() end })

vim.api.nvim_create_autocmd("CmdUndefined", {
	group = vim.api.nvim_create_augroup("amatho_diffview_load", { clear = true }),
	pattern = "Diffview*",
	once = true,
	callback = function()
		vim.cmd.packadd("diffview-plus.nvim")
		require("diffview").setup({
			enhanced_diff_hl = true,
			view = {
				merge_tool = { layout = "diff4_mixed" },
			},
		})
	end,
})

vim.keymap.set("n", "<Leader>hd", "<cmd>DiffviewToggle<cr>", { desc = "Toggle Diffview" })
