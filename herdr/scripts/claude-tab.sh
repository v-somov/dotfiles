#!/bin/sh
# Open Claude in a new herdr tab.
#
# [[keys.command]] has no "tab" type, so the binding runs this detached with
# type = "shell": `herdr tab create` only spawns a shell, and the command is
# typed into the new tab's pane afterwards.
#
# claude-account still picks the account, so the new tab follows the same
# work-vs-personal cwd rule as the pane binding did.

herdr=${HERDR_BIN_PATH:-herdr}
cwd=${HERDR_ACTIVE_PANE_CWD:-$PWD}

set -- --cwd "$cwd" --focus
[ -n "$HERDR_ACTIVE_WORKSPACE_ID" ] && set -- --workspace "$HERDR_ACTIVE_WORKSPACE_ID" "$@"

created=$("$herdr" tab create "$@") || exit 1

pane=$(printf '%s' "$created" | sed -n 's/.*"pane_id":"\([^"]*\)".*/\1/p')
[ -n "$pane" ] || {
  echo "claude-tab: no pane id in tab create response: $created" >&2
  exit 1
}

exec "$herdr" pane run "$pane" claude-account
