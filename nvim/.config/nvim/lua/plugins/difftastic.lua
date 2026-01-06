vim.api.nvim_create_user_command("DifftToggle", function(e)
	local state = require("difftastic-nvim").state

	if state.tree_win or state.left_win or state.right_win then
		vim.cmd("DifftClose")
	else
		vim.cmd("Difft " .. e.args)
	end
end, { nargs = "*" })

return {
	"clabby/difftastic.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	config = function()
		require("difftastic-nvim").setup({
			download = true, -- Auto-download pre-built binary
		})
	end,
	keys = {
		{ "<Leader>hd", "<cmd>DifftToggle<cr>", desc = "Toggle difftastic" },
	},
	lazy = false,
}
