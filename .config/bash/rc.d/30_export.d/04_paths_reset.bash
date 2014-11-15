#! /dev/null/bash

function ___tmp ()
{

    declare cmd tmp

    # Reset PATHs to Defaults
    cmd='/usr/libexec/path_helper'
    if [[ -x "${cmd}" ]]
    then
        eval "$( PATH= MANPATH= "${cmd}" -s )"
    else
        printf 'Path Helper Not Found! ( %s )\n' "${cmd}"
        PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
        MANPATH="/usr/share/man:/usr/local/share/man"
        export PATH MANPATH
    fi

}
___tmp "${@}" 1>&2
unset -f ___tmp
