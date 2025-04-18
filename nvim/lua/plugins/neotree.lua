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
				require("neo-tree.command").execute({ focus = true, reveal = true })
			end,
			desc = "Open Neo-tree",
		},
	},
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {
		-- fill any relevant options here
		filesystem = {
			filtered_items = {
				visible = true,
			},
		},
	},
}
