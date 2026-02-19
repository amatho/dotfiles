return {
	cmd = { "./node_modules/.bin/oxlint", "--lsp" },
	root_markers = { ".oxlintrc.json", "oxlint.config.ts" },
	settings = {
		fixKind = "all",
		typeAware = "true",
	},
}
