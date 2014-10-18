#! /dev/null/bash

set -a

# Enabled color for various terminal programs.
CLICOLOR=1

# Solarized Colors for ( ls )
LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Flexible column widths for ( ls )
# inode, block count, number of links, user name, group name, flags, file size, file name.
LS_COLWIDTHS="0:0:0:0:0:0:0:0"

# Solarized Colors for GNU ( ls )
{ type -t gdircolors || type -t dircolors; } >/dev/null
[ "${?}" -ne 0 ] || {
    I="${HOME_SRC_DIR}/github.com/seebi/dircolors-solarized.git/dircolors.ansi-universal"
    [ ! -r "${I}" ] || eval "$( gdircolors "${I}" )"
    unset I
}

set +a
