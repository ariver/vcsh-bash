#! /dev/null/bash

#
## Setup TMPDIR
#
export TMPDIR

# Verify (and possibly update/create) temporary directory.
TMPDIR="${TMPDIR:-${HOME}/.tmp}"
[ -d "${TMPDIR}/." ] || mkdir -p "${TMPDIR}"
[ -d "${TMPDIR}/." ] && {
    chown -h "${USER:-${LOGNAME:-${USERNAME}}}" "${TMPDIR}/."
    chmod -h go-rwx "${TMPDIR}/."
} || {
    echo "Could not create/verify TMPDIR { ${TMPDIR} }!"
}
