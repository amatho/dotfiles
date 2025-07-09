return {
	"lewis6991/gitsigns.nvim",
	opts = {
		current_line_blame = true,
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { desc = "Next Git change" })

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, { desc = "Previous Git change" })

			-- Actions
			-- visual mode
			map("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Stage hunk" })
			map("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Reset hunk" })
			-- normal mode
			map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
			map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
			map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
			map("n", "<leader>hu", gitsigns.stage_hunk, { desc = "Undo stage hunk" })
			map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
			map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
			map("n", "<leader>hb", gitsigns.blame, { desc = "Blame" })
			-- Toggles
			map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle blame line" })
			map("n", "<leader>tD", gitsigns.preview_hunk_inline, { desc = "Toggle show deleted" })
		end,
	},
}
