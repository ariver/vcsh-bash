#! /dev/null/bash

set -a

# Set by system, usually, but don't assume.
TZ=America/Chicago

# Disable mailcheck.
MAILCHECK=0

#
## History
#

# Disable history temporarily, as I use { histerical } to manage it.
HISTFILE=

# Don't keep commands that start with space.
HISTCONTROL='ignorespace'

# Don't limit size of history file.
HISTFILESIZE=

# Don't keep commands that start with space.
HISTIGNORE=' *'
# Don't keep commands that are 1 or 2 chars long or are standard commands that are used a lot.
#HISTIGNORE='?:??:clear:exit:history:date'

# Format for timestamp from history command.
HISTTIMEFORMAT="%y-%m/%d %H:%M:%S%t"

# Big history size for each session.
HISTSIZE=65535

set +a
