#! /dev/null/bash

function ___tmp ()
{

    # Add default python user base bin dir to path.
    PATH="$( python -c 'from site import getuserbase; print(getuserbase())' )/bin:${PATH}"

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
            /opt/local_macports/{,share/}man \

}
___tmp "${@}" 1>&2
unset -f ___tmp
