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

export   TC_TAB TC_NLN TC_CRT
readonly TC_TAB TC_NLN TC_CRT
