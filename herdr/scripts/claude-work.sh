#!/bin/sh
# Start claude on the work account regardless of the working directory.
# claude-account honors an inherited CLAUDE_CONFIG_DIR, so its cwd rule is skipped.
CLAUDE_CONFIG_DIR=${CLAUDE_WORK_CONFIG_DIR:-$HOME/.claude-work}
export CLAUDE_CONFIG_DIR
exec claude-account "$@"
