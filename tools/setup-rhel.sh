#!/usr/bin/env bash

set -e

PKG_INSTALL=${PKG_INSTALL:-sudo dnf install -y}

$PKG_INSTALL curl procps util-linux-user diffutils man bash-completion

if ! locale -a | grep -q "$LOCALE"; then
  $PKG_INSTALL glibc-locale-source
  sudo localedef -f UTF-8 -i $LOCALE $LOCALE.UTF-8
fi

$PKG_INSTALL python3-pip vim
