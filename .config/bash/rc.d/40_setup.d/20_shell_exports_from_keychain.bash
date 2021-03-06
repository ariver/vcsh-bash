#! /dev/null/bash

# Pull some environment variables from keychain.
___tmp ()
{

    declare keychain_exports=(
        HOMEBREW_GITHUB_API_TOKEN
        EMAIL
        MAILDIR
    )
    export ${keychain_exports[*]}

    declare vars=( I J err_string )
    declare ${vars[*]}

    err_string=":ERR:${BASH_SOURCE}:${FUNCNAME}:${LINENO}:${SECONDS}:${RANDOM}"

    for I in ${keychain_exports[*]}
    do
        J="$( security find-generic-password -w -s shell -a export:${I} 2>/dev/null || echo "${err_string}" )"
        [ "${J}" != "${err_string}" ] || {
            printf 'Not Found: Keyring entry for ( %s )\n' "${I}"
            continue
        }
        eval printf -v "${I}" %s "${J}"
    done

    #declare -p ${keychain_exports[*]}; sleep 0.2

}
___tmp 1>&2
unset -f ___tmp
