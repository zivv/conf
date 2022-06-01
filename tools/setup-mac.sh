#!/usr/bin/env bash

set -e

PKG_INSTALL=${PKG_INSTALL:-brew install}

if ! command -v brew >/dev/null; then
  curl -fsSL https://raw.github.com/Homebrew/install/HEAD/install.sh | bash
fi
$PKG_INSTALL coreutils
$PKG_INSTALL python3 vim

# Optional:
# brew install moreutils
