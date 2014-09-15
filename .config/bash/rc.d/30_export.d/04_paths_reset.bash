#! /dev/null/bash

[ -x /usr/libexec/path_helper ] || return 1

eval "$( PATH= MANPATH= /usr/libexec/path_helper -s )"
