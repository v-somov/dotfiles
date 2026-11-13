#!/bin/sh
# Start claude on the personal account regardless of the working directory.
# claude-account honors an inherited CLAUDE_CONFIG_DIR, so its cwd rule is skipped.
CLAUDE_CONFIG_DIR=$HOME/.claude
export CLAUDE_CONFIG_DIR
exec claude-account "$@"
