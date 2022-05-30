#!/usr/bin/env bash

set -e

[[ ! -z $PKG_INSTALL ]] || (
  echo "Empty \$PKG_INSTALL"
  exit 1
)

if ! command -v brew >/dev/null; then
  curl -fsSL https://raw.github.com/Homebrew/install/HEAD/install.sh | bash
fi
$PKG_INSTALL coreutils
$PKG_INSTALL python3 vim

# Optional:
# brew install moreutils
