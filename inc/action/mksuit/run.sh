. "${incdir}/action/mksuit/help.lib.sh"
. "${incdir}/action/mksuit/opts.inc.sh"

[[ -n "${OPTS[help_func]}" ]] && {
  ${OPTS[help_func]}
  exit
}

rc=0

cp -r "${tooldir}/tests/suit.demo1" "${OPTS[dest]}"

[[ "${rc}" ]] && {
  echo "Suit created in ${OPTS[dest]}"
} || {
  echo "Couldn't created suit in ${OPTS[dest]}" >&2
}

exit ${rc}
