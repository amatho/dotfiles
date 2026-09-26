---@module "snacks"

vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	"https://github.com/MunifTanjim/nui.nvim",
	-- "https://github.com/3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("3") },
})

local function on_move(data)
	Snacks.rename.on_rename_file(data.source, data.destination)
end
local events = require("neo-tree.events")

---@type neotree.Config
require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = true,
		},
	},
	event_handlers = {
		{ event = events.FILE_MOVED, handler = on_move },
		{ event = events.FILE_RENAMED, handler = on_move },
	},
})

vim.keymap.set("n", "<leader>e", function()
	require("neo-tree.command").execute({
		action = "focus",
		position = "float",
		toggle = true,
		reveal = true,
	})
end, { desc = "Open Neo-tree" })
vim.keymap.set("n", "<leader>E", function()
	require("neo-tree.command").execute({ action = "focus", position = "float", toggle = true })
end, { desc = "Open Neo-tree" })
