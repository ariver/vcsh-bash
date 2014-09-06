#! /dev/null/bash

# Use emacs-style readline/history editing.
set -o emacs

# Save notifications about terminated jobs until next prompt.
set +o notify

# Make sure LINES/COLUMNS are current.
shopt -s checkwinsize
# Turn on extended globbing patterns.
shopt -s extglob
# GNU format error messages.
shopt -s gnu_errfmt
# Send HUP to background processes ( if not properly disconnected from term ).
shopt -s huponexit
# Don't check email status on every prompt.
shopt -u mailwarn
# Don't show command completions if I don't have a clue of what I'm doing.
shopt -s no_empty_cmd_completion
# Safe shifting!
shopt -s shift_verbose
# Safe sourcing!
shopt -u sourcepath

# HISTORY
# If history sub fails, present command for editing.
shopt -s histreedit
# Display history sub for review before running.
shopt -s histverify
