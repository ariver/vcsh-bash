#! /dev/null/bash

#
## Setup PATH/MANPATH
#
function bash_paths_init ()
{

    export PATH MANPATH

    declare vars=(
           path_add_head    path_add_hind
        manpath_add_head manpath_add_hind
        IFS
        IFS_DEF
        IFS_RGX
        I J K
    )
    declare ${vars[*]}

    path_add_head=(
        ~/.opt/shimmed/{,s}bin
        ~/.opt/alternators/{,s}bin
    )

    path_add_hind=(
        ~/.local/{,s}bin
        /usr/local/{,s}bin
        /opt/local_macports/{,s}bin
    )

    manpath_add_head=(
        ~/.opt/alternators/man
    )

    manpath_add_hind=(
        ~/.local{,/share}/man
        /usr/local/{,share/}man
        /opt/local_macports/{,share/}man
    )

    if [ -x /usr/libexec/path_helper ]
    then
        eval "$( PATH= MANPATH= /usr/libexec/path_helper -s )"
    else
        printf -v PATH %s: {/usr,}/bin {/usr,}/sbin /usr/local/{,s}bin /opt/X11/bin
        PATH="${PATH%:}"
        printf -v MANPATH %s: {/usr{,/local},/opt/X11}/share/man
        MANPATH="${MANPATH%:}"
    fi

    bash_path_update    "${path_add_head[@]}"    PATH    "${path_add_hind[@]}"
    bash_path_update "${manpath_add_head[@]}" MANPATH "${manpath_add_hind[@]}"

}
bash_paths_init 1>&2
