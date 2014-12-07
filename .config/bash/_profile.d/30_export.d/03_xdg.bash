#! /dev/null/bash

#
## Setup XDG Base Directory Variables
#
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
#
# There is much argument as to whether these vars are to be used for term apps.
# Other than the fact that there are many that do use them,
# I don't see why it isn't a good idea.
# So..

: ${XDG_CONFIG_HOME:=${HOME}/.config}
: ${XDG_CONFIG_DIRS:=/etc/xdg}
: ${XDG_DATA_HOME:=${HOME}/.local/share}
: ${XDG_DATA_DIRS:=/usr/local/share/:/usr/share/}
: ${XDG_CACHE_HOME:=${HOME}/.cache}
: ${XDG_RUNTIME_DIR:=${TMPDIR:-/tmp}}

export   XDG_CONFIG_HOME XDG_CONFIG_DIRS XDG_DATA_HOME XDG_DATA_DIRS XDG_CACHE_HOME XDG_RUNTIME_DIR
readonly XDG_CONFIG_HOME XDG_CONFIG_DIRS XDG_DATA_HOME XDG_DATA_DIRS XDG_CACHE_HOME XDG_RUNTIME_DIR
