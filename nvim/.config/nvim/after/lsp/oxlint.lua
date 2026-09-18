return {
	cmd = { "./node_modules/.bin/oxlint", "--lsp" },
	root_dir = function(_, on_dir)
		on_dir()
	end,
	root_markers = { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts" },
	settings = {
		fixKind = "all",
		typeAware = "true",
	},
}
