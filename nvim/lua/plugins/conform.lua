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
				desc = "[F]ormat buffer",
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
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
				--false
				sh = { "shfmt" },
				["javascript"] = { "prettierd", "prettier" },
				["javascriptreact"] = { "prettierd", "prettier" },
				["typescript"] = { "prettierd", "prettier" },
				["typescriptreact"] = { "prettierd", "prettier" },
				["vue"] = { "prettierd", "prettier" },
				["css"] = { "prettierd", "prettier" },
				["scss"] = { "prettierd", "prettier" },
				["less"] = { "prettierd", "prettier" },
				["html"] = { "prettierd", "prettier" },
				["json"] = { "prettierd", "prettier" },
				["jsonc"] = { "prettierd", "prettier" },
				["yaml"] = { "prettierd", "prettier" },
				["markdown"] = { "prettierd", "prettier" },
				["markdown.mdx"] = { "prettierd", "prettier" },
				["graphql"] = { "prettierd", "prettier" },
				["handlebars"] = { "prettierd", "prettier" },
				["python"] = { "ruff-lsp" },
				["rust"] = { "rustfmt" },
				["go"] = { "goimports", "gofumpt" },
				["toml"] = { "taplo" },
			},
		},
	},
}
