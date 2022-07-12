. "${incdir}/action/run/funcs.lib.sh"
. "${incdir}/action/run/help.lib.sh"
. "${incdir}/action/run/opts.inc.sh"

[[ -n "${OPTS[help_func]}" ]] && {
  ${OPTS[help_func]}
  exit
}

TEST_MOCKDIR="${TESTDIR}/mock"
export PATH_ORIGIN="${PATH}"
PATH="${TEST_MOCKDIR}/bin:${PATH_ORIGIN}"

time_start=$(date +%s)
TESTER_TEST_CNT=0
TESTER_ERR_CNT=0

while read -r TESTFILE; do
  [[ -z "${TESTFILE}" ]] && continue

  __run_test() {
    unset __run_test

    local SUITDIR="$(dirname "${TESTFILE}")"
    local SUITNAME="${SUITDIR##*"${TESTDIR}/suit."}"

    # only run selected suits
    [[ -n "${OPTS[suits]}" ]] && {
      grep -qFx "${SUITNAME}" <<< "${OPTS[suits]}" || return
    }

    local SETUPFILE="$(
      filename="${SUITDIR}/setup.sh"
      [[ -f "${filename}" ]] && echo "${filename}"
    )"
    local SUIT_MOCKDIR="${SUITDIR}/mock"

    # add suit mock bin directory to the PATH
    PATH="${SUIT_MOCKDIR}/bin:${PATH}"

    printf -- '===== SUIT: %s =====\n' "${SUITNAME}"

    [[ -n "${SETUPFILE}" ]] && . "${SETUPFILE}"
    . "${TESTFILE}"

    # remove suit mock bin directory from the PATH
    PATH="${TEST_MOCKDIR}/bin:${PATH_ORIGIN}"
  } && __run_test
done <<< "${testfiles}"

echo '===== RESULT ====='
{
  printf -- '> TOTAL|: %d\n' ${TESTER_TEST_CNT}
  printf -- '> GREEN|: %d\n' $(( TESTER_TEST_CNT - ${TESTER_ERR_CNT} ))
  printf -- '> RED  |: %d\n' ${TESTER_ERR_CNT}
} | column -t -s '|'
time_taken=$(( $(date +%s) - ${time_start} ))
printf -- '# DURATION: %s\n' "$(date -d@${time_taken} -u +%H:%M:%S)"

[[ ${TESTER_ERR_CNT} -gt 0 ]] && exit 1
exit 0
