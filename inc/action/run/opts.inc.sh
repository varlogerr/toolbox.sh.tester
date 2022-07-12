OPTS+=(
  [help_func]=
  [suits]=
)

__opts_detect() {
  unset __opts_detect

  declare -a errbag=()
  declare -a funcs=()
  declare -a err_flags=()
  declare -a diff_flags=()
  local action_shifted=0

  while :; do
    [[ -z "${1+x}" ]] && break
    [[ (${action_shifted} -lt 1 && "${1}" == "${OPTS[action]}") ]] && {
      action_shifted=1
      shift
      continue
    }

    case "${1}" in
      -\?|-h|--help ) OPTS[help_func]=print_help ;;
      --nook        ) TESTER_NOOK='' ;;
      --noerr       ) TESTER_NOERR='' ;;
      --diff        ) TESTER_DIFF='' ;;
      -*            ) errbag+=("Invalid option: ${1}") ;;
      *             ) OPTS[suits]+="${OPTS[suits]:+,}${1}" ;;
    esac

    shift
  done

  [[ "${OPTS[suits]}" ]] && {
    OPTS[suits]="$(sed -e 's/^,//' -e 's/,$//' \
        -e 's/,+/,/g' <<< "${OPTS[suits]}" \
      | tr ',' '\n' <<< "${OPTS[suits]}")"

    while read -r s; do
      [[ ! -d "${TESTDIR}/suit.${s}" ]] \
        && errbag+=("Suit doesn't exist: ${s}")
    done <<< "${OPTS[suits]}"
  }

  [[ ${#errbag[@]} -lt 1 ]] && return

  for e in "${errbag[@]}"; do
    printf -- '%s\n' "${e}"
  done

  echo
  echo "Issue \`${THE_SCRIPT} -h\` for help"
  exit 1
} && __opts_detect "${@}"
