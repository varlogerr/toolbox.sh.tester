OPTS+=(
  [help_func]=
  [dest]=
)

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
      *             )
        [[ -z "${OPTS[dest]}" ]] \
          && OPTS[dest]="${1}" \
          || errbag+=("Only 1 DESTINATION is supported")
        ;;
    esac

    shift
  done

  OPTS[help_func]="${funcs[0]}"

  [[ "${#funcs[@]}" -gt 1 ]] \
    && errbag+=("Only 1 option is supported")

  [[ (-z "${OPTS[help_func]}" && -z "${OPTS[dest]}") ]] \
    && errbag+=("DESTINATION is required")

  [[ (-n "${OPTS[dest]}" && -d "${OPTS[dest]}") ]] && {
    found_files="$(find "${OPTS[dest]}" -mindepth 1 -maxdepth 1)"
    [[ -n "${found_files}" ]] \
      && errbag+=("DESTINATION directory exists and not empty")
  }

  [[ "${#errbag[@]}" -gt 0 ]] && {
    for e in "${errbag[@]}"; do
      printf -- '%s\n' "${e}"
    done

    echo
    echo "Issue \`${THE_SCRIPT} ${OPTS[action]} -h\` for help"
    exit 1
  }
} && __opts_detect "${@}"
