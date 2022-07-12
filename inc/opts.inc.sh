declare -A OPTS=()

__opts_detect() {
  unset __opts_detect

  declare -a errbag=()

  while :; do
    [[ -z "${1+x}" ]] && break

    case "${1}" in
      -\?|-h|--help ) [[ -z "${OPTS[action]+x}" ]] && OPTS[action]=help ;;
      -*            ) errbag+=("Invalid option: ${1}") ;;
      *             )
        [[ -z "${OPTS[action]+x}" ]] \
          && OPTS[action]="${1}" \
          || errbag+=("Only 1 action is supported")
        ;;
    esac

    shift
  done

  if [[ -z "${OPTS[action]}" ]]; then
    errbag+=("Action is required")
  elif grep -qvFx "${available_actions}" <<< "${OPTS[action]}"; then
    errbag+=("Unknown action: ${OPTS[action]}")
    unset OPTS[action]
  fi

  # we don't care about errors if the action is
  # detected, it will take care of errors
  [[ -n "${OPTS[action]}" ]] && return

  for e in "${errbag[@]}"; do
    printf -- '%s\n' "${e}"
  done

  echo
  echo "Issue \`${THE_SCRIPT} -h\` for help"
  exit 1
} && __opts_detect "${@}"
