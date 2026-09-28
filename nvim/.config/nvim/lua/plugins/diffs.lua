vim.g.diffs = {
	gitsigns = true,
	difftastic = true,
}

vim.pack.add({ "https://forge.barrettruth.com/barrettruth/diffs.nvim" })

vim.keymap.set("n", "<leader>co", "<Plug>(diffs-conflict-ours)")
vim.keymap.set("n", "<leader>ct", "<Plug>(diffs-conflict-theirs)")
vim.keymap.set("n", "<leader>cb", "<Plug>(diffs-conflict-both)")
vim.keymap.set("n", "<leader>c0", "<Plug>(diffs-conflict-none)")
vim.keymap.set("n", "]x", "<Plug>(diffs-conflict-next)")
vim.keymap.set("n", "[x", "<Plug>(diffs-conflict-prev)")
