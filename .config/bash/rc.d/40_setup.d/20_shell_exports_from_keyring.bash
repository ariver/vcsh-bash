#! /dev/null/bash

# Pull some environment variables from keyring.
___tmp ()
{

    declare keyring_exports=(
        GIT_HUB_API_TOKEN
        HOMEBREW_GITHUB_API_TOKEN
        EMAIL
        MAILDIR
        SSH_ID_RSA_LOAD
        HOME_SRC_DIR
        HOME_SRC_GITHUB_DIR
        HOME_SRC_GITHUB_MY_DIR
        HOME_SRC_GITHUB_WORK_DIR
        HOME_SRC_GITHUB_WORK_MY_DIR
    )
    export ${keyring_exports[*]}

    declare vars=( I J err_string )
    declare ${vars[*]}

    err_string=":ERR:${BASH_SOURCE}:${FUNCNAME}:${LINENO}:${SECONDS}:${RANDOM}"

    for I in ${keyring_exports[*]}
    do
        J="$( keyring get shell export:${I} || echo "${err_string}" )"
        [ "${J}" != "${err_string}" ] || {
            printf 'Not Found: Keyring entry for ( %s )\n' "${I}"
            continue
        }
        eval printf -v "${I}" %s "${J}"
    done

    #declare -p ${keyring_exports[*]}; sleep 0.2

}
___tmp 1>&2
unset -f ___tmp
