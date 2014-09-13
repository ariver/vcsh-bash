#! /dev/null/bash

set -a

if [[ "${OSTYPE}" != darwin* ]]
then
TMPDIR="${TMPDIR:-${HOME}/.tmp}"
fi

set +a
