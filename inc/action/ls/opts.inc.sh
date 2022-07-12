OPTS+=([help_func]=)

__opts_detect() {
  unset __opts_detect

  declare -a errbag=()
  declare -a funcs=()
  local action_shifted=0

  while :; do
    [[ -z "${1+x}" ]] && break
    [[ (${action_shifted} -lt 1 && "${1}" == "${OPTS[action]}") ]] && {
      action_shifted=1
      shift
      continue
    }

    case "${1}" in
      -\?|-h|--help ) funcs+=(print_help) ;;
      -*            ) errbag+=("Invalid option: ${1}") ;;
      *             ) errbag+=("Unknown action: ${1}") ;;
    esac

    shift
  done

  [[ "${#funcs[@]}" -gt 1 ]] \
    && errbag+=("Only 1 option is supported")

  [[ "${#errbag[@]}" -gt 0 ]] && {
    for e in "${errbag[@]}"; do
      printf -- '%s\n' "${e}"
    done

    echo
    echo "Issue \`${THE_SCRIPT} ${OPTS[action]} -h\` for help"
    exit 1
  }

  OPTS[help_func]="${funcs[0]}"
} && __opts_detect "${@}"
