#! /dev/null/bash

. "$( brew --prefix )/etc/profile.d/bash_completion.sh"

# function _pip_completion
eval "$( pip completion --bash )"

#eval "$( printf 'function ___test1 () { printf "%s\n" "${FUNCNAME}"; }' )"

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
        "$( compgen -c ssh.sso )"               -F  _ssh
#        keystone                                -W  "$( keystone bash-completion )"
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
