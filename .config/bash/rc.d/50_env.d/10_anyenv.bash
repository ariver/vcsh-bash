#! /bin/bash

function anyenv_load ()
{

    export PATH ANYENV_ROOT

    declare vars=(
        ents ent
        ver
        dirs dir
             tc_tab  tc_nln
        IFS IFS_TAB IFS_NLN
    )
    declare ${vars[*]}

    printf -v  tc_tab '\t'
    printf -v IFS_TAB '\t'
    printf -v IFS_NLN '\n'
    printf -v IFS  ' \t\n'

    ANYENV_ROOT=~/.opt/anyenv

    PATH="${ANYENV_ROOT}/bin:${PATH}"

    eval "$( anyenv init - )"

    pyenv activate work

    dirs=()
    ents=( $( anyenv envs ) )

    for ent in "${ents[@]}"
    do
        case "${ent}" in
        ( "pyenv" ) {
            dir="$( { "${ent}" virtualenv-prefix || "${ent}" prefix; } 2>/dev/null )"
        };;
        ( * ) {
            dir="$( { "${ent}" prefix; } 2>/dev/null )"
        };;
        esac
        [ -n "${dir}" ] || continue
        dirs=( "${dirs[@]}" $( find "${dir}" -name man ) )
    done

    bash_path_update "${dirs[@]}" MANPATH
    
}

anyenv_load 1>&2
