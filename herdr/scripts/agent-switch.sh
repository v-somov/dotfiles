#!/usr/bin/env bash
# Fuzzy-jump to a herdr agent. Bound to alt+a as a popup in config.toml.
# Attention-first ordering: blocked, done, working, idle.
set -euo pipefail

HERDR=$(command -v herdr || printf %s "$HOME/.local/bin/herdr")

workspaces=$("$HERDR" workspace list)

# A digit jumps to that row while the query is empty; once typing, it filters as usual.
digit_binds=()
for n in 1 2 3 4 5 6 7 8 9; do
  digit_binds+=(--bind "$n:transform:[ -z {q} ] && echo 'pos($n)+accept' || echo 'put($n)'")
done

# Rows: hidden pane id, then number, status (coloured by urgency), workspace,
# title and cwd in fixed-width columns. Colours are ANSI palette slots so the
# popup follows Ghostty's light/dark theme.
selection=$("$HERDR" agent list | jq -r --argjson ws "$workspaces" '
  def fit($n): if length > $n then .[0:$n-1] + "…" elif length == $n then . else . + (" " * ($n - length)) end;
  def paint($c): "\u001b[" + $c + "m" + . + "\u001b[0m";
  {blocked: "1;31", done: "32", working: "33", idle: "90"} as $tone
  | ($ws.result.workspaces | map({key: .workspace_id, value: .label}) | from_entries) as $labels
  | .result.agents
  | sort_by(.agent_status as $s | ["blocked", "done", "working", "idle"] | index($s) // 9)
  | to_entries[]
  | .key as $i | .value
  | .pane_id + "\t"
    + ("\($i + 1)" | fit(2) | paint("1"))
    + (.agent_status as $st | $st | fit(9) | paint($tone[$st] // "0"))
    + (($labels[.workspace_id] // .workspace_id) | fit(16)) + "  "
    + ((.terminal_title_stripped // .agent) | fit(36)) + "  "
    + (.cwd | sub("^" + env.HOME; "~") | paint("90"))
' | fzf --ansi --reverse --height=100% --no-sort \
        --delimiter='\t' --with-nth=2.. "${digit_binds[@]}" \
        --prompt='› ' --pointer='▸' --info=inline-right --no-scrollbar \
        --separator='─' --highlight-line \
        --header='1-9 jump · enter focus · esc cancel' \
        --color='fg:-1,bg:-1,hl:blue:underline,fg+:-1:bold,bg+:black,hl+:blue:bold:underline' \
        --color='pointer:magenta,prompt:blue,query:-1:bold,info:bright-black' \
        --color='header:bright-black,separator:bright-black,gutter:-1') || exit 0

# The pane id stays in a hidden first field so it can be focused.
[ -n "$selection" ] && exec "$HERDR" agent focus "${selection%%$'\t'*}"
