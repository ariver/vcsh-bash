#! /dev/null/bash

function ___tmp ()
{

    declare vars var

    vars=(
        LC_ALL
        LC_COLLATE
        LC_CTYPE
        LC_MESSAGES
        LC_NUMERIC
    )

    export ${vars[*]}

    # Use UTF8
    for var in "${vars[@]}"
    do
        printf -v var '%s="%s"' "${var}" "en_US.UTF-8"
        eval "${var}"
    done

    # Force distinction of case in sort/glob.
    LC_COLLATE=C

}
___tmp 1>&2
unset -f ___tmp
