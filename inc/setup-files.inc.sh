[[ -d "${TESTDIR}/${setup_suffix}" ]] && {
  while read -r f; do
    [[ -n "${f}" ]] && . "${f}"
  done <<< "$(find "${TESTDIR}/${setup_suffix}" -type f -name '*.sh')"
}
