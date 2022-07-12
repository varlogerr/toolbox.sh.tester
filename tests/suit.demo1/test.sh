exp_rc=0
act_rc=0
assert_result ${exp_rc} ${act_rc} "main setup var" "${MAIN_SETUP_VAR}" \
  "I can guess main setup var value"

exp_rc=0
act_rc=0
assert_result ${exp_rc} ${act_rc} "suit setup var" "${SUIT_SETUP_VAR}" \
  "I can guess suit setup var value"

exp_rc=0
act_rc=0
assert_result ${exp_rc} ${act_rc} "nothing" "something" \
  "Force fail test"

exp_rc=1
exp_txt=""
act_txt="$(BIN_MOCK='' dummy-grep --version)"
assert_result ${exp_rc} $? "${exp_txt}" "${act_txt}" \
  "Dummy grep show version fails"

exp_rc=0
exp_txt="lolo"
act_txt="$(BIN_MOCK='' dummy-grep -o 'lolo' <<< 'ololo')"
assert_result ${exp_rc} $? "${exp_txt}" "${act_txt}" \
  "Dummy grep greps normally"
