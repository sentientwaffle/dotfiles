#!/usr/bin/env bash
# Output a vim-safe version of the system clipboard contents.
# Literal ASCII escapes are replaced with '<ESC>'.
#
# Test with:
#   $ echo -e "hello \x1b Shi" | copy
#   $ _copy_paste.sh | xxd
xclip -o -selection c | sed 's/\x1b/<ESC>/g'
