#! /dev/null/bash

# Color for listings
if [[ "${OSTYPE}" == darwin* ]]
then
    alias ls='ls -G'
    alias gls='gls --color=auto'
else
    alias ls='ls --color=auto'
    alias gls='ls'
fi

# ( Don't let me be passively stupid. )
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# SUDO for Aliases!
# ( *Do* let me be *actively* stupid. )
alias sudo='sudo '

# Doesn't seem to get taken care of by virtualenv.
alias pydoc='python -m pydoc'
