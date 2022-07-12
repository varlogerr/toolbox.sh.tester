print_help() {
  while read -r l; do
    [[ -z "${l}" ]] && continue
    [[ "${l:0:1}" == '!' ]] && l="${l:1}"
    printf -- '%s\n' "${l}"
  done <<< "
    Run tests
   !
    USAGE
    =====
    \`\`\`sh
    ${THE_SCRIPT} ${OPTS[action]} [SUITS] [OPTIONS]
    \`\`\`
   !
    Options
    =======
    --nook  Don't output passing tester result
    --diff  Show side by side diff
   !
    DEMO
    ====
    \`\`\`sh
    # Run tests from \`tests\` directory
    ${THE_SCRIPT} ${OPTS[action]}
   !
    # Run \`suit1\` and \`suit2\`
    # from \`mytests\` directory
    export TESTDIR=mytests
    ${THE_SCRIPT} ${OPTS[action]}
    \`\`\`
  "
}
