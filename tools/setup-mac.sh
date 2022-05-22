#!/usr/bin/env bash

set -e

if ! command -v brew >/dev/null; then
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
fi

brew install coreutils

# Optional:
# brew install moreutils
