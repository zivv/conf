#!/usr/bin/env bash

set -e

PKG_INSTALL=${PKG_INSTALL:-sudo apt install}

# Avoid to input sudo password if already installed.
function check_or_install() {
  for lib in "${@}"; do
    if ! apt list --installed $lib 2>/dev/null | grep $lib; then
      echo "Install $lib ..."
      $PKG_INSTALL $lib
    fi
  done
}

check_or_install software-properties-common curl xclip bc procps

if ! locale -a | grep -q "en_US.utf8"; then
  check_or_install locales
  sudo locale-gen en_US.UTF-8
fi

check_or_install python3-pip vim
if (($(echo "$(
  vim --version | grep "IMproved" | sed 's/.*IMproved \(.*\) (.*/\1/'
) < 8.2" | bc -l))); then
  echo "Install vim 8.2+ ..."
  sudo add-apt-repository ppa:jonathonf/vim
  sudo apt update
  $PKG_INSTALL vim-gtk3
fi

# Optional:
# sudo apt install -y build-essential cmake gcc g++ exuberant-ctags
# sudo apt install -y net-tools ibus-pinyin mosh netcat-openbsd moreutils rename
