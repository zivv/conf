#!/usr/bin/env bash
#
# curl -sf https://raw.githubusercontent.com/zivv/conf/master/tools/setup_mac.sh | bash

set -ex

curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

brew install coreutils python3-pip tmux tree git vim
pip3 install psutil powerline-status trash-cli

# Optional:
# brew install moreutils

if [[ ! -f ~/.dircolors.256dark ]]; then
  curl -Lo ~/.dircolors.256dark \
    https://raw.github.com/seebi/dircolors-solarized/master/dircolors.256dark
fi

brew install fzf fd ripgrep bat git-delta
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

if ! command -v zsh >/dev/null; then
  brew install zsh && touch ~/.zshrc && chsh -s $(command -v zsh)
  curl -Lo ~/.zsh_antigen git.io/antigen
  echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >>~/.zshrc && source ~/.zshrc
fi

if [[ ! -d ~/conf ]]; then
  git clone --depth=1 https://github.com/zivv/conf ~/conf &&
    (cd ~/conf && ./set.sh)
fi
