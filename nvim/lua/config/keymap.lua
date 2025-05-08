local map = vim.keymap.set

map("n", "<M-q>", "<cmd>close<cr>", { desc = "Close window" })

map("v", "<", "<gv")
map("v", ">", ">gv")
