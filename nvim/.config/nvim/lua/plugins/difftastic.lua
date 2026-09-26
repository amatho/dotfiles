vim.api.nvim_create_user_command("DifftToggle", function(e)
	local state = require("difftastic-nvim").state

	if state.tree_win or state.left_win or state.right_win then
		vim.cmd("DifftClose")
	else
		vim.cmd("Difft " .. e.args)
	end
end, { nargs = "*" })

vim.pack.add({
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/clabby/difftastic.nvim",
})

require("difftastic-nvim").setup({
	download = true, -- Auto-download pre-built binary
})

vim.keymap.set("n", "<Leader>ht", "<cmd>DifftToggle<cr>", { desc = "Toggle difftastic" })
