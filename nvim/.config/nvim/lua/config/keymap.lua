local map = vim.keymap.set
local delmap = vim.keymap.del

map("n", "<M-q>", "<cmd>close<cr>", { desc = "Close window" })
map({ "n", "v" }, "<C-J>", "5j", { desc = "Go down 5 lines" })
map({ "n", "v" }, "<C-K>", "5k", { desc = "Go up 5 lines" })

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlight" })

delmap({ "n", "x" }, "gra")
delmap("n", "gri")
delmap("n", "grn")
delmap("n", "grr")

-- LSP specific keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("amatho_lsp_attach_keymaps", { clear = true }),
	callback = function(event)
		local lspmap = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local picker = require("snacks.picker")

		lspmap("gd", picker.lsp_definitions, "Goto definition")
		lspmap("gD", vim.lsp.buf.declaration, "Goto declaration")
		lspmap("gr", picker.lsp_references, "Goto references")
		lspmap("gI", picker.lsp_implementations, "Goto implementation")
		lspmap("<leader>d", picker.diagnostics, "Diagnostics")
		lspmap("<leader>D", picker.lsp_type_definitions, "Type definition")
		lspmap("<leader>ls", picker.lsp_symbols, "Symbols")
		lspmap("<leader>lS", picker.lsp_workspace_symbols, "Workspace symbols")
		lspmap("<leader>r", vim.lsp.buf.rename, "Rename")
		lspmap("<leader>a", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
		lspmap("<leader>p", vim.lsp.buf.signature_help, "Signature help")
		lspmap("L", vim.diagnostic.open_float, "Show diagnostics")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			lspmap("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle Inlay Hints")
		end
	end,
})
