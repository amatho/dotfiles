local map = vim.keymap.set
map({ "i", "s" }, "kj", "<esc>", { desc = "Exit insert mode" })
map({ "i", "s" }, "jk", "<esc>", { desc = "Exit insert mode" })
map("n", "<leader>p", vim.lsp.buf.signature_help, { desc = "Signature help" })
