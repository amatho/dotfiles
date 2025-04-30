local augroup = function(name)
	return vim.api.nvim_create_augroup("amatho" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	group = augroup("auto_reload"),
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})
