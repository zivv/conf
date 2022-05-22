#!/usr/bin/env bash
#
# curl -sf https://raw.githubusercontent.com/zivv/conf/master/init.sh | bash

set -e

DIR=$(dirname $(realpath "$BASH_SOURCE"))
RAW_URL="https://raw.githubusercontent.com/zivv/conf/master/"

function run() {
  local f=$1
  if [[ -f $DIR/$f ]]; then
    $DIR/$f
  else
    curl -sf $RAW_URL/$f | bash
  fi
}

echo "### basic"
if [[ $(uname) == "Darwin" ]]; then
  run tools/setup-mac.sh
  PKG_INSTALL="brew install"
else
  run tools/setup-ubuntu.sh
  PKG_INSTALL="sudo apt install -y"
fi
$PKG_INSTALL python3-pip tmux tree git vim
if [[ ! -d ~/conf ]]; then
  git clone --depth=1 https://github.com/zivv/conf ~/conf
  ~/conf/set.sh
fi

echo "### powerline"
if ! pip3 show powerline-status >/dev/null; then
  pip3 install powerline-status
fi
if ! ls ~/.local/share/fonts/*Powerline.otf >/dev/null; then
  mkdir -p ~/.local/share/fonts
  pushd ~/.local/share/fonts >/dev/null
  curl -fLo "Source Code Pro Semibold for Powerline.otf" \
    https://github.com/powerline/fonts/raw/master/SourceCodePro/Source%20Code%20Pro%20Semibold%20for%20Powerline.otf
  popd >/dev/null
  fc-cache -f -v
fi

echo "### tmux"
# To use powerline for statusline.
if ! pip3 show psutil >/dev/null; then
  pip3 install psutil
fi

SHL=${SHL:-zsh}
echo "### shell - $SHL"
if [[ ! -f ~/.dircolors.256dark ]]; then
  echo "Install github.com/seebi/dircolors-solarized"
  curl -Lo ~/.dircolors.256dark \
    https://raw.github.com/seebi/dircolors-solarized/master/dircolors.256dark
fi
if [[ $SHL == "zsh" ]]; then
  run tools/setup-zsh.sh
fi
# Needs bash anyway.
if ! grep -q ".sh_base" ~/.bashrc; then
  echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >>~/.bashrc
fi

echo "### vim"
vim -c q
vim -c PlugInstall -c q -c q
if [[ ! -d ~/.vim/UltiSnips ]]; then
  git clone --depth=1 https://github.com/zivv/UltiSnips.git ~/.vim/UltiSnips
fi

echo "### tools"

if ! command -v trash-put >/dev/null; then
  echo "Install https://github.com/andreafrancia/trash-cli"
  pip3 install trash-cli
fi

if ! command -v fzf >/dev/null; then
  echo "Install https://github.com/junegunn/fzf"
  if [[ $(uname) == "Darwin" ]]; then
    brew install fzf
    $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
  else
    # https://github.com/junegunn/fzf#using-linux-package-managers
    # sudo apt install fzf
    # NOTE: Key bindings (CTRL-T / CTRL-R / ALT-C) and fuzzy auto-completion may not be enabled by default.
    #       Refer to the package documentation for more information. (e.g. apt-cache show fzf)
    # https://github.com/junegunn/fzf#using-git
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc
  fi
fi

if ! command -v fd >/dev/null; then
  echo "Install https://github.com/sharkdp/fd"
  # See https://github.com/sharkdp/fd#installation.
  # Try `fd-find` / `fd` for package manager or check https://github.com/sharkdp/fd/releases.
  if [[ $(uname) == "Darwin" ]]; then
    brew install fd
  else
    sudo apt install fd-find || (
      curl -Lo /tmp/fd.deb github.com/sharkdp/fd/releases/download/v8.1.1/fd_8.1.1_amd64.deb
      sudo dpkg -i /tmp/fd.deb
    )
  fi
fi

if ! command -v rg >/dev/null; then
  echo "Install https://github.com/BurntSushi/ripgrep"
  # See https://github.com/BurntSushi/ripgrep#installation.
  # Try `ripgrep` for package manager or check https://github.com/BurntSushi/ripgrep/releases.
  if [[ $(uname) == "Darwin" ]]; then
    brew install ripgrep
  else
    curl -Lo /tmp/rg.deb \
      https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
    sudo dpkg -i /tmp/rg.deb
  fi
fi

if ! command -v bat >/dev/null; then
  echo "Install https://github.com/sharkdp/bat"
  # See https://github.com/sharkdp/bat#installation.
  # Try `bat` for package manager or check https://github.com/sharkdp/bat/releases.
  if [[ $(uname) == "Darwin" ]]; then
    brew install bat
  else
    curl -Lo /tmp/bat.deb \
      https://github.com/sharkdp/bat/releases/download/v0.17.1/bat_0.17.1_amd64.deb
    sudo dpkg -i /tmp/bat.deb
  fi
fi

if ! command -v delta >/dev/null; then
  echo "Install https://github.com/dandavison/delta"
  # See https://github.com/dandavison/delta#installation.
  # Download the tarball from https://github.com/dandavison/delta/releases.
  if [[ $(uname) == "Darwin" ]]; then
    brew install git-delta
  else
    curl -Lo /tmp/delta.tar.gz \
      https://github.com/dandavison/delta/releases/download/0.5.0/delta-0.5.0-x86_64-unknown-linux-gnu.tar.gz
    tar xvf /tmp/delta.tar.gz -C /tmp
    sudo mv /tmp/delta-0.5.0-x86_64-unknown-linux-gnu/delta /usr/local/bin
  fi
fi
