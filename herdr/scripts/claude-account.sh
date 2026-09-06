#!/bin/sh
# Pick the Claude account from the working directory, then exec the real binary.
#
# Single source of truth for the work-vs-personal decision. It lives in a script
# rather than in zshrc because the herdr alt+c binding runs its command without
# an interactive shell, so a zsh function or alias is not visible there.
#
# An inherited CLAUDE_CONFIG_DIR always wins, which keeps `ccw`/`ccp` and any
# explicit env prefix working. Personal deliberately leaves the variable unset:
# the default profile is the personal account, and pointing the variable at
# ~/.claude would select a profile that is not logged in.

CLAUDE_WORK_PATHS="
$HOME/Developer/SE
$HOME/Developer/adm
$HOME/Developer/obsidian/work
$HOME/Developer/gitlab-mr-bot
$HOME/Developer/mrq
"

if [ -z "$CLAUDE_CONFIG_DIR" ]; then
  for p in $CLAUDE_WORK_PATHS; do
    case "$PWD" in
      "$p" | "$p"/*)
        CLAUDE_CONFIG_DIR="$HOME/.claude-work"
        export CLAUDE_CONFIG_DIR
        break
        ;;
    esac
  done
fi

exec "$HOME/.local/bin/claude" "$@"
