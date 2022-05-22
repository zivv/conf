#!/usr/bin/env bash

set -e

[[ ! -z $PKG_INSTALL ]] || (
  echo "Empty \$PKG_INSTALL"
  exit 1
)

$PKG_INSTALL software-properties-common curl xclip
$PKG_INSTALL python3-pip vim

if (($(echo "$(
  vim --version | grep "IMproved" | sed 's/.*IMproved \(.*\) (.*/\1/'
) < 8.2" | bc -l))); then
  # To install vim 8.2:
  sudo add-apt-repository ppa:jonathonf/vim
  sudo apt update
  $PKG_INSTALL vim-gtk3=2:8.2\*
fi

# Optional:
# sudo apt install -y build-essential cmake gcc g++ exuberant-ctags
# sudo apt install -y net-tools ibus-pinyin mosh netcat-openbsd moreutils rename
