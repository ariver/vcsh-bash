#! /dev/null/bash

# Use UTF8
LC_ALL='en_US.UTF-8'
LC_CTYPE="${LC_ALL}"
LC_MESSAGES="${LC_ALL}"
LC_NUMERIC="${LC_ALL}"

# Force distinction of case in sort/glob.
LC_COLLATE='C'

export LC_ALL LC_COLLATE LC_CTYPE LC_MESSAGES LC_NUMERIC
