#! /bin/bash

function ___tmp ()
{

    export  WORKON_HOME=~/.opt/venv_py

    declare venvw="$( type -p virtualenvwrapper.sh )"

    [ -n "${venvw}" ] || return

    . "${venvw}"

}

___tmp 1>&2
unset -f ___tmp
