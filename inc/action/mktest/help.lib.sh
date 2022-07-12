print_help() {
  while read -r l; do
    [[ -z "${l}" ]] && continue
    [[ "${l:0:1}" == '!' ]] && l="${l:1}"
    printf -- '%s\n' "${l}"
  done <<< "
    Generate test folder skeleton
   !
    USAGE
    =====
    \`\`\`sh
    ${THE_SCRIPT} ${OPTS[action]} DESTINATION
    \`\`\`
   !
    DEMO
    =====
    \`\`\`sh
    # Generate to \`./mytests\` directory
    ${THE_SCRIPT} ${OPTS[action]} ./mytests
    \`\`\`
  "
}
