return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
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
