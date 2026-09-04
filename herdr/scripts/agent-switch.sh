#!/usr/bin/env bash
# Fuzzy-jump to a herdr agent. Bound to alt+a as a popup in config.toml.
# Attention-first ordering: blocked, done, working, idle.
set -euo pipefail

HERDR=/Users/vladsomov/.local/bin/herdr

workspaces=$("$HERDR" workspace list)

selection=$("$HERDR" agent list | jq -r --argjson ws "$workspaces" '
  ($ws.result.workspaces | map({key: .workspace_id, value: .label}) | from_entries) as $labels
  | .result.agents
  | sort_by(.agent_status as $s | ["blocked", "done", "working", "idle"] | index($s) // 9)
  | .[]
  | [
      .pane_id,
      (.agent_status | ascii_upcase),
      ($labels[.workspace_id] // .workspace_id),
      (.terminal_title_stripped // .agent),
      (.cwd | sub("^" + env.HOME; "~"))
    ]
  | @tsv
' | awk -F'\t' '{printf "%-12s %-8s %-18s %-26s %s\n", $1, $2, $3, $4, $5}' \
  | fzf --prompt='agent> ' --reverse --height=100% --no-sort \
        --header='enter: focus   esc: cancel') || exit 0

[ -n "$selection" ] && exec "$HERDR" agent focus "${selection%% *}"
