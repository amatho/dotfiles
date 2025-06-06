local map = vim.keymap.set
local delmap = vim.keymap.del

map("n", "<M-q>", "<cmd>close<cr>", { desc = "Close window" })
map({ "n", "v" }, "<C-J>", "5j", { desc = "Go down 5 lines" })
map({ "n", "v" }, "<C-K>", "5k", { desc = "Go up 5 lines" })

map("v", "<", "<gv")
map("v", ">", ">gv")

delmap({ "n", "x" }, "gra")
delmap("n", "gri")
delmap("n", "grn")
delmap("n", "grr")

-- LSP specific keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("amatho_lsp_attach", { clear = true }),
	callback = function(event)
		local lspmap = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		lspmap("gd", require("snacks.picker").lsp_definitions, "[G]oto [D]efinition")
		lspmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		lspmap("gr", require("snacks.picker").lsp_references, "[G]oto [R]eferences")
		lspmap("gI", require("snacks.picker").lsp_implementations, "[G]oto [I]mplementation")
		lspmap("<leader>d", require("snacks.picker").diagnostics, "[D]iagnostics")
		lspmap("<leader>D", require("snacks.picker").lsp_type_definitions, "Type [D]efinition")
		lspmap("<leader>ls", require("snacks.picker").lsp_symbols, "[S]ymbols")
		lspmap("<leader>lS", require("snacks.picker").lsp_workspace_symbols, "Workspace [S]ymbols")
		lspmap("<leader>r", vim.lsp.buf.rename, "[R]ename")
		lspmap("<leader>a", vim.lsp.buf.code_action, "Code [A]ction", { "n", "x" })
		lspmap("<leader>p", vim.lsp.buf.signature_help, "Signature help")
		lspmap("L", vim.diagnostic.open_float, "Show diagnostics")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			lspmap("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})
