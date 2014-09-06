#! /dev/null/bash

. "$( brew --prefix )/etc/profile.d/bash_completion.sh"

# function _pip_completion
eval "$( pip completion --bash )"

#eval "$( printf 'function ___test1 () { printf "%s\n" "${FUNCNAME}"; }' )"
