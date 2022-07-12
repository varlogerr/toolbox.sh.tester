echo "Available actions:"
sed 's/^/* /' <<< "${available_actions}"

echo
echo "Issue \`${THE_SCRIPT} ACTION -h\` for help"
