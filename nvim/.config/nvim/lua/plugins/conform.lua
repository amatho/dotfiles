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
				biome = {
					require_cwd = true,
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				["javascript"] = { "oxfmt", "biome" },
				["javascriptreact"] = { "oxfmt", "biome" },
				["typescript"] = { "oxfmt", "biome" },
				["typescriptreact"] = { "oxfmt", "biome" },
				["vue"] = { "oxfmt" },
				["css"] = { "oxfmt" },
				["scss"] = { "oxfmt" },
				["less"] = { "oxfmt" },
				["html"] = { "oxfmt" },
				["json"] = { "oxfmt", "biome" },
				["jsonc"] = { "oxfmt", "biome" },
				["yaml"] = { "yamlfmt", "oxfmt" },
				["markdown"] = { "oxfmt" },
				["markdown.mdx"] = { "oxfmt" },
				["graphql"] = { "oxfmt", "biome" },
				["handlebars"] = { "oxfmt" },
				["rust"] = { "rustfmt" },
				["go"] = { "goimports", "gofumpt" },
				["toml"] = { "taplo" },
			},
		},
	},
}
