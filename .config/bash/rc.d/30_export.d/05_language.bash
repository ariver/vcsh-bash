#! /dev/null/bash

set -a

# Use UTF8
LC_ALL='en_US.UTF-8'
LC_CTYPE="${LC_ALL}"
LC_MESSAGES="${LC_ALL}"
LC_NUMERIC="${LC_ALL}"

# Force distinction of case in sort/glob.
LC_COLLATE='C'

set +a
