#! /dev/null/bash

# Pull some environment variables from keyring.
___tmp ()
{

    declare keyring_exports=(
        EMAIL
        MAILDIR
        GIT_HUB_API_TOKEN
        HOMEBREW_GITHUB_API_TOKEN
        GITHUB_HOME_BASE_DIR
        GITHUB_WORK_BASE_DIR
    )
    export ${keyring_exports[*]}

    declare vars=( I J )
    declare ${vars[*]}

    for I in ${keyring_exports[*]}
    do
        J="$( keyring get bash export:${I} )" || continue
        printf -v "${I}" %s "${J}"
    done

    declare -p ${keyring_exports[*]}

}
___tmp 1>&2
unset -f ___tmp
