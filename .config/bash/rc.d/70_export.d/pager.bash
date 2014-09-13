#! /dev/null/bash

# Set default pager based on what is available.
function ___tmp ()
{

    export PAGER

    declare vars=(
        ents
        ent
        cmd
        I
    )
    declare ${vars[*]}

    ents=(
        vimpager    vimpager
        less        "less -isR"
        more        more
        cat         cat
    )
    
    for (( I=0; I<${#ents[@]}; I+=2 ))
    do
        ent="${ents[${I}]}"
        cmd="${ents[$((I+1))]}"
        type -t "${ent}" >/dev/null || continue
        PAGER="${cmd}"
        break
    done

}
___tmp 1>&2
unset -f ___tmp
