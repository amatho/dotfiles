local map = vim.keymap.set
map("i", "kj", "<esc>", { desc = "Exit insert mode" })
map("i", "jk", "<esc>", { desc = "Exit insert mode" })
map("n", "gn", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "gp", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
