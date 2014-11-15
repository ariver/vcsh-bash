#! /dev/null/bash

return

___tmp="$( brew --prefix )/etc/profile.d/bash_completion.sh"
[ ! -e "${___tmp}" ] || . "${___tmp}" ]
unset ___tmp

# function _pip_completion
type -t pip >/dev/null
[ "${?}" -ne 0 ] || eval "$( pip completion --bash )"

function ___tmp ()
{

    declare vars=(
        comp_ents
        I J
    )

    comp_ents=(
        ""                                      -A  command
        "$( compgen -A function function )"     -A  function
        brewI                                   -F  _brew_install
        brewU                                   -F  _brew_uninstall
        brewu                                   -F  _brew_update
        brewup                                  -F  _brew_upgrade
        brews                                   -F  _brew_search
        brewl                                   -F  _brew_list
        "brewi brewh"                           -F  _brew_info
        "$( compgen -c ssh. )"                  -F  _ssh
    )

    for (( I=0; I<${#comp_ents[@]}; I+=3 ))
    do
        for J in ${comp_ents[${I}]}
        do
            [ -n "${J}" ] || continue
            complete ${comp_ents[$((I+1))]} "${comp_ents[$((I+2))]}" ${J}
        done
    done

}
___tmp 1>&2
unset -f ___tmp
