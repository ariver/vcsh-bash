#! /dev/null/bash

function gits ()
{ git status "${@}"; }

function gitC ()
{ git commit -m "lazy.. no notes" "${@}"; }

function git_url_go ()
{
    declare vars=(
        dirs dir
        src
        url
    )
    declare ${vars[*]}
    dirs=( "${@}" )
    [ "${#@}" -gt 0 ] || dirs=( . )
    for dir in "${dirs[@]}"
    do
        src="$( git config remote.origin.url )"
        printf "# %s\t= %s\t@ " "${dir}" "${src}"
        [[ "${src}" =~ ^([^@]*)@([^:/]*):(.*)$ ]] \
            && url="https://${BASH_REMATCH[2]}/${BASH_REMATCH[3]%.git}"
        printf "%s\n" "${url}"
        [ -z "${url}" ] || {
            open "${url}"
            continue
        }
        printf "  Did not open URL\n"
    done
}

function git_show_ignored ()
{
    declare tc_tab
    printf -v tc_tab '\t'
    git ls-files --others |
        git check-ignore --verbose --stdin |
        sed "s/:/${tc_tab}/;s/:/${tc_tab}/" |
        { [ -t 1 ] && column -ts"${tc_tab}" || cat -; }
}