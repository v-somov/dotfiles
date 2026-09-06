#!/bin/sh
# Pick the Claude account from the working directory, then exec the real binary.
#
# Single source of truth for the work-vs-personal decision. It lives in a script
# rather than in zshrc because the herdr alt+c binding runs its command without
# an interactive shell, so a zsh function or alias is not visible there.
#
# Which directories count as work is machine-specific and stays out of this
# public repo. List them one per line in the paths file below; blank lines and
# lines starting with # are ignored, and a leading ~/ is expanded:
#
#     ~/src/acme
#     ~/notes/work
#
# With no paths file every directory is personal, which is the safe default.
#
# An inherited CLAUDE_CONFIG_DIR always wins, which keeps an explicit env prefix
# and the ccw/ccp aliases working.

paths_file=${CLAUDE_ACCOUNT_PATHS:-${XDG_CONFIG_HOME:-$HOME/.config}/claude-account/work-paths}
work_dir=${CLAUDE_WORK_CONFIG_DIR:-$HOME/.claude-work}

if [ -z "$CLAUDE_CONFIG_DIR" ] && [ -r "$paths_file" ]; then
  while IFS= read -r prefix || [ -n "$prefix" ]; do
    case $prefix in
      '' | \#*) continue ;;
      '~/'*) prefix="$HOME/${prefix#\~/}" ;;
    esac
    case $PWD in
      "$prefix" | "$prefix"/*)
        CLAUDE_CONFIG_DIR=$work_dir
        export CLAUDE_CONFIG_DIR
        break
        ;;
    esac
  done < "$paths_file"
fi

# Resolved rather than bare, so `ps` still shows the real binary path.
claude_bin=$(command -v claude) || {
  echo "claude-account: claude not found in PATH" >&2
  exit 127
}
exec "$claude_bin" "$@"
