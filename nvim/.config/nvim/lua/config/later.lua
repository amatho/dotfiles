local pending = {}

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("amatho_later", { clear = true }),
	once = true,
	callback = function()
		for _, fn in ipairs(pending) do
			vim.schedule(fn)
		end
		pending = nil
	end,
})

return function(fn)
	if pending then
		table.insert(pending, fn)
	else
		fn()
	end
end
