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
			notify_on_error = true,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true, stop_after_first = true },
				--false
				sh = { "shfmt" },
				["javascript"] = { "prettierd", "prettier", stop_after_first = true },
				["javascriptreact"] = { "prettierd", "prettier", stop_after_first = true },
				["typescript"] = { "prettierd", "prettier", stop_after_first = true },
				["typescriptreact"] = { "prettierd", "prettier", stop_after_first = true },
				["vue"] = { "prettierd", "prettier", stop_after_first = true },
				["css"] = { "prettierd", "prettier", stop_after_first = true },
				["scss"] = { "prettierd", "prettier", stop_after_first = true },
				["less"] = { "prettierd", "prettier", stop_after_first = true },
				["html"] = { "prettierd", "prettier", stop_after_first = true },
				["json"] = { "prettierd", "prettier", stop_after_first = true },
				["jsonc"] = { "prettierd", "prettier", stop_after_first = true },
				["yaml"] = { "prettierd", "prettier", stop_after_first = true },
				["markdown"] = { "prettierd", "prettier", stop_after_first = true },
				["markdown.mdx"] = { "prettierd", "prettier", stop_after_first = true },
				["graphql"] = { "prettierd", "prettier", stop_after_first = true },
				["handlebars"] = { "prettierd", "prettier", stop_after_first = true },
				["python"] = { "ruff-lsp" },
				["rust"] = { "rustfmt" },
				["go"] = { "goimports", "gofumpt" },
				["toml"] = { "taplo" },
				["nix"] = { "nixfmt" },
			},
		},
	},
}
