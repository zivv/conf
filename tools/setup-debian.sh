#!/usr/bin/env bash

set -e

PKG_INSTALL=${PKG_INSTALL:-sudo apt install -y --no-install-recommends}

$PKG_INSTALL software-properties-common curl xclip bc procps

if ! locale -a | grep -q "$LOCALE"; then
  $PKG_INSTALL locales
  sudo sed -i "s/# $LOCALE/$LOCALE/" /etc/locale.gen
  sudo dpkg-reconfigure --frontend=noninteractive locales
fi

$PKG_INSTALL python3-pip vim-gtk3
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
