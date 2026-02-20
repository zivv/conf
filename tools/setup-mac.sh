#!/usr/bin/env bash

set -e

PKG_INSTALL=${PKG_INSTALL:-brew install}

if ! command -v brew >/dev/null; then
  curl -fsSL https://raw.github.com/Homebrew/install/HEAD/install.sh | bash
fi

if [[ ! -d /usr/local/bin ]]; then
  sudo mkdir -p /usr/local/bin
fi

if [[ $(bash --version | head -n1 | awk '{print $4}') == 3.2* ]]; then
  $PKG_INSTALL bash
  sudo ln -sv $(brew --prefix)/bin/bash /usr/local/bin/
fi

$PKG_INSTALL coreutils
if [[ ! -f /usr/local/bin/cp ]]; then
  sudo ln -sv $(command -v gcp) /usr/local/bin/cp
fi

$PKG_INSTALL python@3 vim
for cmd in python3 vim; do
  if [[ $(realpath $(command -v $cmd)) != $(realpath $(brew --prefix)/bin/$cmd) ]]; then
    sudo ln -sv $(brew --prefix)/bin/$cmd /usr/local/bin/
  fi
done

# Optional:
# brew install moreutils
