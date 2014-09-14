#! /dev/null/bash

true || \
{
    I="$( find "${BASH_SOURCE[0]%.bash}".* \! -path "${BASH_SOURCE[0]}" -a -name "*.bash" -a \( -type f -o -type l \) -a -size +0 -a -print | sed 's/.*/echo "- &" 1>\&2; . "&"/' )"
    eval "${I}"
    return 0
}

function ___bash_config ()
{

    ___bash_config_init

    ___bash_config_show ___bash_config_load "${BASH_SOURCE[0]%.bash}".*

    ___bash_config_tidy

}

function ___bash_config_init ()
{

    declare vars=(
        cols
    )
    declare ${vars[*]}

    unset ___BASH_CONFIG_SHOW_TAG
    unset ___BASH_CONFIG_SHOW_1ST

    : ${___BASH_CONFIG_SHOW_FLG_SKIP:=0}
    [[
        "${___BASH_CONFIG_SHOW_FLG_SKIP}" -eq 0
        &&
        -n "${TERM}" && "${TERM}" != "dumb"
        &&
        "${-}" == *i*
        &&
        -t 1 && -t 2
    ]] \
        || ___BASH_CONFIG_SHOW_FLG_SKIP=1

    #___BASH_CONFIG_SHOW_FLG_SKIP=0
    [ "${___BASH_CONFIG_SHOW_FLG_SKIP}" -ne 0 ] || {
        cols="${COLUMNS:-$( tput cols )}"
        : ${___BASH_CONFIG_SHOW_TAG:=?}
        : ${___BASH_CONFIG_SHOW_1ST:=}
        : ${___BASH_CONFIG_SHOW_MAX:=${cols:-80}}
    }

    exec 7>&1 8>&2
    exec 1>&2

}

function ___bash_config_list ()
{

    declare vars=(
        srcs src
    )
    declare ${vars[*]}
   
    srcs=( "${@}" )

    for src in "${srcs[@]}"
    do

        [[
            "${src}" != "${BASH_SOURCE[0]}"
            &&
            -r "${src}"
        ]] \
            || continue

        case "${src##*.}" in

        ( d ) {

            [ -d "${src}/." ] || continue

            ___bash_config_list "${src}"/*

        };;

        ( bash ) {

            [ -f "${src}" -o -h "${src}" ] || continue

            echo "${#src}" 1>&2

        };;

        esac

    done

}

function ___bash_config_load ()
{

    declare vars=(
        srcs src
    )
    declare ${vars[*]}
   
    srcs=( "${@}" )

    for src in "${srcs[@]}"
    do

        [[
            "${src}" != "${BASH_SOURCE[0]}"
            &&
            -r "${src}"
        ]] \
            || continue

        case "${src##*.}" in

        ( d ) {

            [ -d "${src}/." ] || continue

            ___bash_config_show ___bash_config_load "${src}"/*

        };;

        ( bash ) {

            [ -f "${src}" -o -h "${src}" ] || continue

            ___bash_config_show ___bash_config_show_source "${src}"

        };;

        esac

    done

}

function ___bash_config_show ()
{

    declare vars=(
        cmd_show
        cmd
        args arg
        src
        tag
        pad
        pad_chr
        flg_silent
        TIMEFORMAT
    )
    declare ${vars[*]}

    cmd_show=()
    cmd="${1}"
    shift
    args=( "${@}" )
    flg_silent=1

    if [ "${___BASH_CONFIG_SHOW_FLG_SKIP}" -eq 0 ]
    then

        for arg in "${args[@]}"
        do
            [ -e "${arg%/*}" ] \
                || continue
            [ "${arg##*.}" == "d" -o "${arg##*.}" == "bash" ] \
                || continue
            case "${cmd}" in
            ( ___bash_config_load ) {
                src="${arg%/*}"
                pad_chr="-"
            };;
            ( ___bash_config_show_source ) {
                src="${arg}"
                pad_chr="."
            };;
            esac
            [ -e "${src%/*}/.silent" ] || flg_silent=0
            break
        done

        : ${___BASH_CONFIG_SHOW_1ST:=${src}}

        [ "${flg_silent}" -ne 0 ] || cmd_show=( time )

        if [ "${src}" == "${___BASH_CONFIG_SHOW_1ST}" ]
        then
            TIMEFORMAT=' RT  UT  ST'
            tag='SRC'
            pad_chr="="
        else
            TIMEFORMAT='%1R %1U %1S'
            tag="${src#${___BASH_CONFIG_SHOW_1ST}/}"
            tag="${tag%.bash}"
            tag="${tag//\// }"
        fi

        pad="$(( ___BASH_CONFIG_SHOW_MAX - ${#tag} - 17 ))"
        printf -v pad '%0*d' "${pad}"
        pad="${pad//0/${pad_chr}}"

        printf -v TIMEFORMAT -- ' %s %s %s %s' "${pad_chr}" "${tag}" "${pad}" "${TIMEFORMAT}"
        ___BASH_CONFIG_SHOW_TAG="${tag}"

    fi

    eval "${cmd_show[@]}" "${cmd}" "${args[@]}"

}

function ___bash_config_show_source ()
{

    if [ "${___BASH_CONFIG_SHOW_FLG_SKIP}" -eq 0 ]
    then
        exec 1> >( ___bash_config_show_source_tag '?' "${___BASH_CONFIG_SHOW_TAG}" 1>&8 )
        exec 2> >( ___bash_config_show_source_tag '!' "${___BASH_CONFIG_SHOW_TAG}" 1>&8 )
    fi

    builtin source "${@}"

    exec 1>&7 2>&8
    exec 1>&2

}

function ___bash_config_show_source_tag ()
{

    declare I

    while read -r I
    do
        printf -- ' %s %s\n' "${*}" "${I}"
    done

}

function ___bash_config_tidy ()
{

    declare fncs=(
        #$( compgen -A function ___bash_config )
        ___bash_config
        ___bash_config_init
        ___bash_config_list
        ___bash_config_load
        ___bash_config_show
        ___bash_config_show_source
        ___bash_config_show_source_tag
        ___bash_config_tidy
    )
    declare vars=(
        #$( compgen -A variable ___BASH_CONFIG )
        ___BASH_CONFIG_SHOW_TAG
        ___BASH_CONFIG_SHOW_1ST
        ___BASH_CONFIG_SHOW_FLG_SKIP
        ___BASH_CONFIG_SHOW_MAX
    )

    unset -f ${fncs[*]}
    unset    ${vars[*]}

    exec 1>&7 2>&8
    exec 7>&- 8>&-

}

___bash_config
