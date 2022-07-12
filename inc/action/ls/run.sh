. "${incdir}/action/ls/help.lib.sh"
. "${incdir}/action/ls/opts.inc.sh"

[[ -n "${OPTS[help_func]}" ]] && {
  ${OPTS[help_func]}
  exit
}

[[ -n "${testfiles}" ]] && {
  rev <<< "${testfiles}" | cut -d'/' -f2 \
  | rev | cut -d'.' -f2-
}
