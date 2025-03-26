local map = vim.keymap.set
map("i", "kj", "<esc>", { desc = "Exit insert mode" })
map("i", "jk", "<esc>", { desc = "Exit insert mode" })
map("n", "gn", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "gp", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "<M-w>", function()
	Snacks.bufdelete()
end, { desc = "Delete buffer" })

-- Global LSP mappings
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
