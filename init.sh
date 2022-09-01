#!/usr/bin/env bash
#
# Init all environments.
#
# Test in docker images:
#   docker run --rm -it ubuntu:22.04 bash
#     apt update && apt install -y sudo curl
#     useradd -mGsudo zi && echo zi:123456 | chpasswd && su - zi
#   docker run --rm -it almalinux:9.0 bash
#     dnf install -y --nobest --allowerasing curl sudo
#     useradd -mGwheel zi && echo zi:123456 | chpasswd && su - zi

set -e

RAW_URL="https://raw.github.com/zivv/conf/HEAD/"
if realpath "$BASH_SOURCE" &>/dev/null; then
  DIR=$(dirname $(realpath "$BASH_SOURCE"))
else
  DIR="~/conf"
fi
function run() {
  local f=$1
  if [[ -f $DIR/$f ]]; then
    $DIR/$f
  else
    curl -fsSL $RAW_URL/$f | bash
  fi
}

echo "### basic"
if [[ $(uname) == "Darwin" ]]; then
  export PKG_INSTALL="brew install -q"
  run tools/setup-mac.sh
elif [[ $(uname) == "Linux" ]] && grep ID_LIKE /etc/os-release |
  grep -q debian; then
  export PKG_INSTALL="sudo apt install -y --no-install-recommends --no-upgrade"
  export DEBIAN_FRONTEND=noninteractive
  run tools/setup-debian.sh
elif [[ $(uname) == "Linux" ]] && grep ID_LIKE /etc/os-release |
  grep -q rhel; then
  export PKG_INSTALL="sudo dnf install -y --nobest --allowerasing"
  run tools/setup-rhel.sh
else
  echo >&2 "Unsupported OS"
  exit 1
fi
$PKG_INSTALL tmux tree git fontconfig
if [[ ! -d ~/conf ]]; then
  git clone --depth=1 https://github.com/zivv/conf ~/conf
  ~/conf/set.sh
fi

echo "### powerline"
# https://github.com/powerline/powerline
# For shell prompts:
# https://powerline.readthedocs.org/en/master/usage/shell-prompts.html
# For other plugins (like vim, tmux, ipython, etc):
# https://powerline.readthedocs.org/en/master/usage/other.html
if ! pip3 show powerline-status >/dev/null; then
  pip3 install powerline-status
fi
# https://github.com/powerline/fonts
# https://powerline.readthedocs.io/en/latest/installation/linux.html#fonts-installation
# To install all fonts:
#   git clone https://github.com/powerline/fonts.git --depth=1 && (cd fonts && ./install.sh)
FONT_DIR=~/.local/share/fonts
if ! ls $FONT_DIR/*Powerline*.otf >/dev/null; then
  mkdir -p $FONT_DIR
  pushd $FONT_DIR >/dev/null
  curl -fLo "Source Code Pro Semibold for Powerline.otf" \
    https://raw.github.com/powerline/fonts/HEAD/SourceCodePro/Source%20Code%20Pro%20Semibold%20for%20Powerline.otf
  popd >/dev/null
  fc-cache -vf $FONT_DIR
fi

echo "### tmux"
# To use powerline for statusline.
if ! pip3 show psutil >/dev/null; then
  pip3 install psutil
fi

SHL=${SHL:-zsh}
echo "### shell - $SHL"
# https://github.com/seebi/dircolors-solarized
if [[ ! -f ~/.dircolors.256dark ]]; then
  curl -Lo ~/.dircolors.256dark \
    https://raw.github.com/seebi/dircolors-solarized/HEAD/dircolors.256dark
fi
if [[ $SHL == "zsh" ]]; then
  run tools/setup-zsh.sh
fi
# Needs bash anyway.
if ! grep -q ".sh_base" ~/.bashrc; then
  echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >>~/.bashrc
fi

echo "### vim"
yes | vim -c PlugInstall -c q -c q
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
    tar xf /tmp/delta.tar.gz -C /tmp
    sudo mv -v /tmp/delta-0.5.0-x86_64-unknown-linux-gnu/delta /usr/local/bin
  fi
fi
