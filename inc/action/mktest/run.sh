. "${incdir}/action/mktest/help.lib.sh"
. "${incdir}/action/mktest/opts.inc.sh"

[[ -n "${OPTS[help_func]}" ]] && {
  ${OPTS[help_func]}
  exit
}

rc=0
mkdir -p "${OPTS[dest]}"

while read -r f; do
  [[ -z "${f}" ]] && continue
  [[ "${rc}" -lt 1 ]] && cp -r "${tooldir}/tests/${f}" "${OPTS[dest]}"
  rc=${?}
done <<< "
  mock
  setup
  suit.demo1
"

[[ "${rc}" ]] && {
  echo "Tests directory created in ${OPTS[dest]}"
} || {
  echo "Couldn't created test directory in ${OPTS[dest]}" >&2
}

exit ${rc}
