#!/bin/sh
# delta with light/dark taken from the macOS appearance. delta's own detection
# asks the terminal, which gets no answer through herdr, so it fell back to dark.
if defaults read -g AppleInterfaceStyle >/dev/null 2>&1; then
  exec delta --dark "$@"
else
  exec delta --light "$@"
fi
