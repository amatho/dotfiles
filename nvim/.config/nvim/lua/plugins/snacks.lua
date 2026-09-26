---@module "snacks"

vim.pack.add({ "https://github.com/folke/snacks.nvim" })

---@type snacks.Config
require("snacks").setup({
	bigfile = { enabled = true },
	indent = {
		enabled = true,
		char = "│",
		animate = {
			enabled = false,
		},
	},
	input = { enabled = true },
	picker = {
		enabled = true,
		formatters = {
			file = {
				truncate = 80,
			},
		},
		sources = {
			grep = {
				hidden = true,
			},
			files = {
				hidden = true,
			},
		},
	},
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
})

local map = vim.keymap.set

map("n", "<leader>g", function()
	Snacks.picker.grep()
end, { desc = "Grep" })
map("n", "<leader>o", function()
	Snacks.picker.files()
end, { desc = "Files" })
map("n", "<leader>b", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
map("n", "<leader>hB", function()
	Snacks.git.blame_line()
end, { desc = "Blame line (Snacks)" })
map("n", "<leader>?g", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps" })
map("n", "<leader>?l", function()
	Snacks.picker.keymaps({ global = false, ["local"] = true })
end, { desc = "Keymaps (only local)" })
map("n", "<leader>sr", function()
	Snacks.picker.resume()
end, { desc = "Resume picker" })
map("n", "<M-w>", function()
	Snacks.bufdelete()
end, { desc = "Delete buffer" })
