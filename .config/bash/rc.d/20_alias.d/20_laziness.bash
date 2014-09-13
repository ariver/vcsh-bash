#! /dev/null/bash

# Fit side-by-side diff to terminal width.
alias diffy='diff -W ${COLUMNS:-60} -y'

# Truecrypt in text-mode.
if [[ "${OSTYPE}" == darwin* ]]
then
    alias truecrypt='/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt --text'
fi
