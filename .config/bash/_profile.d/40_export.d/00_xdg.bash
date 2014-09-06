#! /dev/null/bash

#
## Setup XDG Base Directory Variables
#
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
#
set -a
: ${XDG_CONFIG_HOME:=${HOME}/.config}
: ${XDG_CONFIG_DIRS:=/etc/xdg}
: ${XDG_DATA_HOME:=${HOME}/.local/share}
: ${XDG_DATA_DIRS:=/usr/local/share/:/usr/share/}
: ${XDG_CACHE_HOME:=${HOME}/.cache}
: ${XDG_RUNTIME_DIR:=${TMPDIR:-/tmp}}
set +a
