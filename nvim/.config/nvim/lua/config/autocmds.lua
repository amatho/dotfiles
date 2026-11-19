local augroup = function(name)
	return vim.api.nvim_create_augroup("amatho_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.hl.hl_op({ higroup = "Visual", timeout = 300 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("treesitter"),
	callback = function(args)
		if not pcall(vim.treesitter.start, args.buf) then
			return
		end
		local lang = vim.treesitter.language.get_lang(args.match) or args.match
		if vim.treesitter.query.get(lang, "indents") then
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	group = augroup("auto_reload"),
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})
