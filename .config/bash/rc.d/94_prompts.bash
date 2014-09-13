#! /dev/null/bash

set -a

PS1_BAK="${PS1_BAK:-${PS1}}"
PS1='\$ '
PS4='+${BASH_SOURCE}+${FUNCNAME}+ '

set +a
