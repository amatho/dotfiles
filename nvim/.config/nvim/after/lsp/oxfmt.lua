return {
	root_dir = function(_, on_dir)
		on_dir()
	end,
	root_markers = { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" },
}
