---@module "snacks"

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false, -- neo-tree will lazily load itself
	keys = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({ action = "focus", position = "float", toggle = true })
			end,
			desc = "Open Neo-tree",
		},
		{
			"<leader>E",
			function()
				require("neo-tree.command").execute({
					action = "focus",
					position = "float",
					toggle = true,
					reveal = true,
				})
			end,
			desc = "Open Neo-tree",
		},
	},
	opts = function()
		local function on_move(data)
			Snacks.rename.on_rename_file(data.source, data.destination)
		end
		local events = require("neo-tree.events")

		---@type neotree.Config
		return {
			filesystem = {
				filtered_items = {
					visible = true,
				},
			},
			event_handlers = {
				{ event = events.FILE_MOVED, handler = on_move },
				{ event = events.FILE_RENAMED, handler = on_move },
			},
		}
	end,
}
