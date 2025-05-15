return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("snacks.picker").lsp_definitions, "[G]oto [D]efinition")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("gr", require("snacks.picker").lsp_references, "[G]oto [R]eferences")
				map("gI", require("snacks.picker").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>d", require("snacks.picker").diagnostics, "[D]iagnostics")
				map("<leader>D", require("snacks.picker").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ls", require("snacks.picker").lsp_symbols, "[S]ymbols")
				map("<leader>lS", require("snacks.picker").lsp_workspace_symbols, "Workspace [S]ymbols")
				map("<leader>r", vim.lsp.buf.rename, "[R]ename")
				map("<leader>a", vim.lsp.buf.code_action, "Code [A]ction", { "n", "x" })
				map("<leader>p", vim.lsp.buf.signature_help, "Signature help")
				map("L", vim.diagnostic.open_float, "Show diagnostics")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			} or {},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		})

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
			stylua = {},
			vtsls = {
				root_markers = { "tsconfig.json", "jsconfig.json", ".git" },
				settings = {
					typescript = {
						preferences = {
							importModuleSpecifier = "relative",
						},
					},
					javascript = {
						preferences = {
							importModuleSpecifier = "relative",
						},
					},
					vtsls = {
						autoUseWorkspaceTsdk = true,
						experimental = {
							completion = {
								enableServerSideFuzzyMatch = true,
							},
						},
					},
				},
			},
			eslint = {},
			terraformls = {},
			pyright = {
				settings = {
					pyright = {
						-- Using Ruff's import organizer
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							-- Ignore all files for analysis to exclusively use Ruff for linting
							ignore = { "*" },
						},
					},
				},
			},
			ruff = {},
			prettierd = {},
			rust_analyzer = {},
		}

		require("mason-tool-installer").setup({ ensure_installed = vim.tbl_keys(servers) })

		for server_name, server in pairs(servers) do
			vim.lsp.enable(server_name)
			vim.lsp.config(server_name, server)
		end

		-- Mason does not support installing nixd, so we configure it manually
		if vim.fn.executable("nixd") == 1 then
			vim.lsp.enable("nixd")
		end
	end,
}
