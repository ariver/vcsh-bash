#! /dev/null/bash

set -a

#
SSL_CERT_FILE=~/.src/github.com/bagder/ca-bundle.git/ca-bundle.crt
GIT_SSL_CAINFO="${SSL_CERT_FILE}"
CURL_CA_BUNDLE="${SSL_CERT_FILE}"

set +a
