vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("amatho_pack_changed", { clear = true }),
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

require("plugins.colorscheme")
require("plugins.snacks")

for file in vim.fs.dir(vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "plugins")) do
	require("plugins." .. vim.fn.fnamemodify(file, ":r"))
end
