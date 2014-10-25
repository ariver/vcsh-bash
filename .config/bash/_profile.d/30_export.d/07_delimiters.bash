#! /dev/null/bash

#
## Delimeters
#

# Tab-character
printf -v TC_TAB '\t'

# Newline-character
printf -v TC_NLN '\n'

# Return-character
printf -v TC_CRT '\r'

export   ${!TC_*}
readonly ${!TC_*}
