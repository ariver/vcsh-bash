#! /dev/null/bash

set -a

# Inform curl (and other web-enabled programs) to not use proxies for listed domains.
no_proxy=localhost,*.local,*.localdomain
NO_PROXY="${no_proxy}"

set +a
