#!/bin/sh
# Claude Code status line. Also publishes the session's state for Herdr's mods:
# plan limits to ~/.cache/herdr-claude/limits.json (jj-limits), and the session,
# its folder and context use as claude.* labels on the Herdr terminal (jj-agents,
# jj-spaces).

input=$(cat)

dir="$HOME/.cache/herdr-claude"
mkdir -p "$dir"
limits=$(printf '%s' "$input" | jq -c '.rate_limits // empty')
if [ -n "$limits" ] && [ "$limits" != "$(cat "$dir/limits.json" 2>/dev/null)" ]; then
  printf '%s\n' "$limits" >"$dir/limits.json.$$" && mv "$dir/limits.json.$$" "$dir/limits.json"
fi

if [ -n "$HC_TERMINAL_ID" ] && command -v hc >/dev/null 2>&1; then
  set --
  while IFS= read -r label; do set -- "$@" "$label"; done <<EOF
$(printf '%s' "$input" | jq -r '
  "claude.session=\(.session_id // "")",
  "claude.cwd=\(.workspace.project_dir // .cwd // "")",
  "claude.context=\(.context_window.used_percentage // "")",
  "claude.context_size=\(.context_window.context_window_size // "")"')
EOF
  hc label "$HC_TERMINAL_ID" "$@" >/dev/null 2>&1
fi

printf '%s' "$input" | jq -r '"\(.model.display_name) \(.context_window.used_percentage // 0)% context"'
