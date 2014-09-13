#! /dev/null/bash

# Set default editor based on what is available.
function ___tmp ()
{

    export FCEDIT VISUAL EDITOR

    declare vars=(
        ents
        ent
        cmd
        I
    )
    declare ${vars[*]}

    ents=(
        vim     vim
        vi      vi
    )
    
    for (( I=0; I<${#ents[@]}; I+=2 ))
    do
        ent="${ents[${I}]}"
        cmd="${ents[$((I+1))]}"
        type -t "${ent}" >/dev/null || continue
        FCEDIT="${cmd}"
        break
    done

    VISUAL="${FCEDIT}"
    EDITOR="${FCEDIT}"

}
___tmp 1>&2
unset -f ___tmp
