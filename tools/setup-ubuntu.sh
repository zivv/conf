#!/usr/bin/env bash

set -e

sudo apt install -y software-properties-common curl xclip

if (($(echo "$(
  vim --version | grep "IMproved" | sed 's/.*IMproved \(.*\) (.*/\1/'
) < 8.2" | bc -l))); then
  # To install vim 8.2:
  sudo add-apt-repository ppa:jonathonf/vim
  sudo apt update
  sudo apt install vim-gtk3=2:8.2\*
fi

# Optional:
# sudo apt install -y build-essential cmake gcc g++ exuberant-ctags
# sudo apt install -y net-tools ibus-pinyin mosh netcat-openbsd moreutils rename
