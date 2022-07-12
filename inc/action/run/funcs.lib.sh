assert_result() {
  local rc_exp=${1}
  local rc_act=${2}
  local txt_exp="${3}"
  local txt_act="${4}"
  local msg="${5}"
  local prefix_ok=OK
  local prefix_err=ERR
  local failure_txt=""

  [[ ${rc_exp} -ne ${rc_act} ]] && {
    failure_txt+="${failure_txt:+$'\n'}RC expected: ${rc_exp}"
    failure_txt+="${failure_txt:+$'\n'}RC actual: ${rc_act}"
  }

  if [[ "${txt_exp}" != "${txt_act}" ]]; then
    if [[ "${TESTER_DIFF+x}" ]]; then
      failure_txt+="${failure_txt:+$'\n'}Text expected | Text actual"
      failure_txt+="${failure_txt:+$'\n'}$(diff -W 130 -y -a -t \
        <(fold -w 60 <<< "${txt_exp}") <(fold -w 60 <<< "${txt_act}") | sed 's/^/  /')"
    else
      failure_txt+="${failure_txt:+$'\n'}Text expected:"
      failure_txt+="${failure_txt:+$'\n'}$(sed 's/^/  /' <<< "${txt_exp}")"
      failure_txt+="${failure_txt:+$'\n'}Text actual:"
      failure_txt+="${failure_txt:+$'\n'}$(sed 's/^/  /' <<< "${txt_act}")"
    fi
  fi

  if [[ -n "${failure_txt}" ]]; then
    (( TESTER_ERR_CNT++ ))
    if [[ -z "${TESTER_NOERR+x}" ]]; then
      echo "${prefix_err}: ${msg}"
      sed 's/^/  /' <<< "${failure_txt}"
    fi
  elif [[ -z "${TESTER_NOOK+x}" ]]; then
    echo "${prefix_ok}: ${msg}"
  fi

  (( TESTER_TEST_CNT++ ))

  [[ -n "${failure_txt}" ]] && return 1
  return 0
}
