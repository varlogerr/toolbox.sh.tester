__iife() {
  unset __iife

  local curdir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
  PATH="${curdir}/bin:${PATH}"
  PATH="${curdir}/vendor/.bin:${PATH}"
  ENVAR_NAME=tester
} && __iife
