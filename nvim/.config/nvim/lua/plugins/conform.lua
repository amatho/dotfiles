return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return { timeout_ms = 1000, lsp_format = "fallback" }
				end
			end,
			notify_on_error = true,
			stop_after_first = true,
			formatters = {
				oxfmt = {
					require_cwd = true,
				},
				prettier = {
					require_cwd = true,
				},
				prettierd = {
					require_cwd = true,
				},
				biome = {
					require_cwd = true,
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				["javascript"] = { "oxfmt", "biome", "prettierd", "prettier" },
				["javascriptreact"] = { "oxfmt", "biome", "prettierd", "prettier" },
				["typescript"] = { "oxfmt", "biome", "prettierd", "prettier" },
				["typescriptreact"] = { "oxfmt", "biome", "prettierd", "prettier" },
				["vue"] = { "prettierd", "prettier" },
				["css"] = { "oxfmt", "prettierd", "prettier" },
				["scss"] = { "oxfmt", "prettierd", "prettier" },
				["less"] = { "oxfmt", "prettierd", "prettier" },
				["html"] = { "oxfmt", "prettierd", "prettier" },
				["json"] = { "oxfmt", "biome", "prettierd", "prettier" },
				["jsonc"] = { "oxfmt", "biome", "prettierd", "prettier" },
				["yaml"] = { "yamlfmt", "oxfmt", "prettierd", "prettier" },
				["markdown"] = { "oxfmt", "prettierd", "prettier" },
				["markdown.mdx"] = { "oxfmt", "prettierd", "prettier" },
				["graphql"] = { "oxfmt", "biome", "prettierd", "prettier" },
				["handlebars"] = { "prettierd", "prettier" },
				["rust"] = { "rustfmt" },
				["go"] = { "goimports", "gofumpt" },
				["toml"] = { "taplo" },
			},
		},
	},
}
