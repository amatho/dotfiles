vim.pack.add({ "https://github.com/MunifTanjim/nui.nvim" })
vim.pack.add({ "https://github.com/julienvincent/hunk.nvim" }, { load = function() end })

vim.api.nvim_create_autocmd("CmdUndefined", {
	group = vim.api.nvim_create_augroup("amatho_hunk_load", { clear = true }),
	pattern = "DiffEditor",
	once = true,
	callback = function()
		vim.cmd.packadd("hunk.nvim")
		require("hunk").setup({})
	end,
})
