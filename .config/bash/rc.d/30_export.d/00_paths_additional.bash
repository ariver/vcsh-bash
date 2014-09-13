#! /dev/null/bash

# Ensure default PATH/MANPATH
eval "$( PATH= MANPATH= /usr/libexec/path_helper -s )"

# Prefix alternatives path, append my own paths.
bash_path_update \
        ~/.opt/alternators/{,s}bin \
        PATH \
        ~/.local/{,s}bin \
        /usr/local/{,s}bin \
        /opt/local_macports/{,s}bin \

# Prefix alternatives manpath, append my own manpaths.
bash_path_update \
        ~/.opt/alternators/man \
        MANPATH \
        ~/.local{,/share}/man \
        /usr/local/{,share/}man \
        /opt/local_macports/{,share/}man
