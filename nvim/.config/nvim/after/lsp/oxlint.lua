return {
	root_dir = function(_, on_dir)
		on_dir()
	end,
	root_markers = { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts" },
}
