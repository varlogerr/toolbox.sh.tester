#!/bin/bash

THE_SCRIPT="$(basename "${BASH_SOURCE[0]}")"
bindir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
tooldir="$(realpath "${bindir}/..")"
incdir="$(realpath "${tooldir}/inc")"
setup_suffix="setup"

TESTDIR="$(realpath -m "${TESTDIR:-$(pwd)/tests}")"

# TODO
# find actions here fails due to absent TESTDIR directory
# for actions like `mktest`

# collect test files
testfiles="$(find "${TESTDIR}" -name 'test.sh' \
    ! -path "${TESTDIR}/${setup_suffix}/*" \
  | sort -n | grep -E 'suit\.[^/]+/test\.sh$')"
# source global setup files
. "${incdir}/setup-files.inc.sh"

available_actions="$(
  find "${incdir}/action" -maxdepth 2 \
    -type f -name 'run.sh' \
  | rev | cut -d'/' -f2 | rev | sort -n)"

# source opts detector, produces OPTS[action]
# variable with the action to execute
. "${incdir}/opts.inc.sh"

[[ (
  ! -d "${TESTDIR}" \
  && *" ${OPTS[action]} "* == ' help mksuit mktest run '
) ]] && {
  {
    echo "No test directory: ${TESTDIR}"
    echo
    echo "Issue \`${THE_SCRIPT} ACTIONS -h\` for help"
  } >&2
  exit 1
}

. "${incdir}/action/${OPTS[action]}/run.sh"
