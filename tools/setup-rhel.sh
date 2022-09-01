#!/usr/bin/env bash

set -e

PKG_INSTALL=${PKG_INSTALL:-sudo dnf install}

# Avoid to input sudo password if already installed.
function check_or_install() {
  for lib in "${@}"; do
    if ! dnf list installed $lib 2>/dev/null | grep $lib; then
      echo "Install $lib ..."
      $PKG_INSTALL $lib
    fi
  done
}
check_or_install curl procps python3-pip vim
