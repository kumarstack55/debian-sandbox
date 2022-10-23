#!/bin/bash

err() {
  echo "$1" 1>&2
}

die() {
  echo "${1:-Died.}"
  exit 1
}

ensure() {
  # shellcheck disable=SC2048
  $* || die "Failed to execute: $*"
}

ignore() {
  # shellcheck disable=SC2048
  $*
}

log() {
  err "$(date +%F) $1"
}

echo_flag_file() {
  local depth=${1:-1}
  echo "/.${FUNCNAME[$depth]}"
}

# shellcheck disable=SC2120
test_if_flag_file_exists() {
  local depth=${1:-2} f
  f=$(echo_flag_file "$depth")
  [ -f "$f" ]
}

# shellcheck disable=SC2120
touch_flag_file() {
  local depth=${1:-2} f
  f=$(echo_flag_file "$depth")
  sudo touch "$f"
}

apt_get_update_executed() {
  # shellcheck disable=SC2119
  test_if_flag_file_exists && return 0

  sudo apt-get update

  # shellcheck disable=SC2119
  touch_flag_file
}

poetry_installed() {
  # shellcheck disable=SC2119
  test_if_flag_file_exists && return 0

  sudo apt-get install python3-distutils -y
  curl -sSL https://install.python-poetry.org | python3 -

  # shellcheck disable=SC2119
  touch_flag_file
}

dotfiles_installed() {
  # shellcheck disable=SC2119
  test_if_flag_file_exists && return 0

  sudo apt-get install curl neovim git -y

  cd /tmp || die
  curl -LO https://raw.githubusercontent.com/kumarstack55/dotfiles/master/bootstrap.sh
  chmod -v +x bootstrap.sh
  ./bootstrap.sh

  # shellcheck disable=SC2119
  touch_flag_file
}

shelcheck_installed() {
  # shellcheck disable=SC2119
  test_if_flag_file_exists && return 0

  sudo apt-get install shellcheck -y

  # shellcheck disable=SC2119
  touch_flag_file
}

main() {
  apt_get_update_executed || die
  dotfiles_installed || die
  poetry_installed || die
  shelcheck_installed || die
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
