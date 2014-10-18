#! /bin/bash

function ___tmp ()
{

    export WORKON_HOME

    declare vars=(
        venvw
    )
    declare ${vars[*]}

    WORKON_HOME=~/.opt/venv_py

    venvw="$( type -p virtualenvwrapper.sh )"

    [ -n "${venvw}" ] || return

    . "${venvw}"

    workon work

}

___tmp 1>&2
unset -f ___tmp
