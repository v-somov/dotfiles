#!/usr/bin/env bash
set -euo pipefail

tmp=$(mktemp /tmp/tmux-links.XXXXXX)
trap 'rm -f "$tmp"' EXIT

tmux capture-pane -J -p \
    | grep -oE '([a-zA-Z0-9_-]+(/[a-zA-Z0-9_.,@~+/-]+)+)|https?://[^ ]+' \
    | sed "s|^~|$HOME|" \
    | sort -u > "$tmp"

[[ ! -s "$tmp" ]] && tmux display-message "No links found" && exit 0

selected=""
if command -v fzf-tmux >/dev/null 2>&1; then
    selected=$(cat "$tmp" | fzf-tmux -p -w 80 -h 20 --prompt="Open: " || true)
else
    selected=$(cat "$tmp" | fzf --prompt="Open: " || true)
fi

[[ -z "$selected" ]] && exit 0

session=$(tmux display-message -p '#{session_name}')

if [[ "$selected" =~ ^https?:// ]]; then
    open "$selected"
else
    path="$selected"
    if [[ "$path" != /* ]]; then
        cwd=$(tmux display-message -p '#{pane_current_path}')
        path="$cwd/$path"
    fi

    VAULT_PATH="${OBSIDIAN_VAULT_PATH:-$HOME/Developer/obsidian/work}"
    if [[ "$path" == "$VAULT_PATH"* ]]; then
        vault_name=$(basename "$VAULT_PATH")
        rel_path="${path#$VAULT_PATH/}"
        encoded=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$rel_path''', safe=''))" 2>/dev/null || echo "$rel_path")
        open "obsidian://open?vault=$vault_name&file=$encoded"
    else
        TMUX_OPEN_PATH="$path" tmux split-window -t "$session:" -h 'nvim "$TMUX_OPEN_PATH"'
    fi
fi
