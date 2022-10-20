#!/bin/bash

err() {
  echo "$1" 1>&2
}

die() {
  echo "${1:-Died.}"
  exit 1
}

ensure() {
  $* || die "Failed to execute: $*"
}

ignore() {
  $*
}

log() {
  err "$(date +%F) $1"
}

poetry_installed() {
  sudo apt-get install python3-distutils -y

  curl -sSL https://install.python-poetry.org | python3 -
}

dotfiles_installed() {
  sudo apt-get install curl neovim git -y

  cd /tmp
  curl -LO https://raw.githubusercontent.com/kumarstack55/dotfiles/master/bootstrap.sh
  chmod -v +x bootstrap.sh
  ./bootstrap.sh
}

main() {
  sudo apt-get update
  poetry_installed || die
  dotfiles_installed || die
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
