#! /dev/null/bash

set -a

[[ "${OSTYPE}" != darwin* ]] || {
    printf -v __CF_USER_TEXT_ENCODING '0x%X:0:0' "${UID}"
    ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future
}

set +a
