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

export LOCALE="en_GB"

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
function pkg_install() {
  local pkgs=""
  for pkg in "${@}"; do
    if ! $PKG_LIST_CMD $pkg 2>/dev/null | grep $pkg; then
      pkgs+="$pkg "
    fi
  done
  if [[ -n "$pkgs" ]]; then
    echo "#### Packages to be installed: $pkgs"
    $PKG_INST_CMD $pkgs
  fi
}
export -f pkg_install
export PKG_INSTALL="pkg_install"
if [[ $(uname) == "Darwin" ]]; then
  export PKG_LIST_CMD="brew ls --versions"
  export PKG_INST_CMD="brew install -q"
  run tools/setup-mac.sh
elif [[ $(uname) == "Linux" ]] && grep -q debian /etc/os-release; then
  export PKG_LIST_CMD="apt list --installed"
  export PKG_INST_CMD="sudo apt install -y --no-install-recommends --no-upgrade"
  export DEBIAN_FRONTEND=noninteractive
  run tools/setup-debian.sh
elif [[ $(uname) == "Linux" ]] && grep -q rhel /etc/os-release; then
  export PKG_LIST_CMD="dnf list installed"
  export PKG_INST_CMD="sudo dnf install -y --nobest --allowerasing"
  run tools/setup-rhel.sh
else
  echo >&2 "Unsupported OS"
  exit 1
fi
$PKG_INSTALL tmux tree git fontconfig

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
  curl -fLo ~/.dircolors.256dark \
    https://raw.github.com/seebi/dircolors-solarized/HEAD/dircolors.256dark
fi
if [[ $SHL == "zsh" ]]; then
  run tools/setup-zsh.sh
fi
# Needs bash anyway.
if ! grep -q ".sh_base" ~/.bashrc; then
  echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >>~/.bashrc
fi

echo "### conf"
if [[ ! -d ~/conf ]]; then
  git clone --depth=1 https://github.com/zivv/conf ~/conf
  ~/conf/set.sh
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
  if command -v brew >/dev/null; then
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
  if ! $PKG_INSTALL fd-find && ! $PKG_INSTALL fd; then
    version=8.4.0
    if [[ $(uname) == "Linux" ]] && grep -q debian /etc/os-release; then
      curl -fLo /tmp/fd.deb github.com/sharkdp/fd/releases/download/v$version/fd_${version}_amd64.deb
      sudo dpkg -i /tmp/fd.deb
    else
      # https://github.com/sharkdp/fd#on-redhat-enterprise-linux-8-rhel8-or-almalinux-8-or-rocky-linux-8
      release=fd-v$version-$(uname -m)-unknown-linux-gnu
      curl -fLo /tmp/fd.tar.gz github.com/sharkdp/fd/releases/download/v$version/$release.tar.gz
      tar xzf /tmp/fd.tar.gz -C /tmp
      sudo install -o root -g root -m 0755 -v /tmp/$release/fd /usr/local/bin
      sudo cp -v /tmp/$release/fd.1 /usr/share/man/man1
      sudo cp -v /tmp/$release/autocomplete/fd.bash /usr/share/bash-completion/completions/
      sudo cp -v /tmp/$release/autocomplete/_fd /usr/share/zsh/site-functions/
    fi
  fi
fi

if ! command -v rg >/dev/null; then
  echo "Install https://github.com/BurntSushi/ripgrep"
  # See https://github.com/BurntSushi/ripgrep#installation.
  # Try `ripgrep` for package manager or check https://github.com/BurntSushi/ripgrep/releases.
  if ! $PKG_INSTALL ripgrep; then
    version=13.0.0
    if [[ $(uname) == "Linux" ]] && grep -q debian /etc/os-release; then
      curl -fLo /tmp/rg.deb github.com/BurntSushi/ripgrep/releases/download/$version/ripgrep_${version}_amd64.deb
      sudo dpkg -i /tmp/rg.deb
    else
      release=ripgrep-$version-$(uname -m)-unknown-linux-musl
      curl -fLo /tmp/rg.tar.gz github.com/BurntSushi/ripgrep/releases/download/$version/$release.tar.gz
      tar xzf /tmp/rg.tar.gz -C /tmp
      sudo install -o root -g root -m 0755 -v /tmp/$release/rg /usr/local/bin
      sudo cp -v /tmp/$release/doc/rg.1 /usr/share/man/man1
      sudo cp -v /tmp/$release/complete/rg.bash /usr/share/bash-completion/completions/
      sudo cp -v /tmp/$release/complete/_rg /usr/share/zsh/site-functions/
    fi
  fi
fi

if ! command -v bat >/dev/null; then
  echo "Install https://github.com/sharkdp/bat"
  # See https://github.com/sharkdp/bat#installation.
  # Try `bat` for package manager or check https://github.com/sharkdp/bat/releases.
  if ! $PKG_INSTALL bat; then
    version=0.21.0
    if [[ $(uname) == "Linux" ]] && grep -q debian /etc/os-release; then
      curl -fLo /tmp/bat.deb github.com/sharkdp/bat/releases/download/v$version/bat_${version}_amd64.deb
      sudo dpkg -i /tmp/bat.deb
    else
      release=bat-v$version-$(uname -m)-unknown-linux-gnu
      curl -fLo /tmp/bat.tar.gz github.com/sharkdp/bat/releases/download/v$version/$release.tar.gz
      tar xzf /tmp/bat.tar.gz -C /tmp
      sudo install -o root -g root -m 0755 -v /tmp/$release/bat /usr/local/bin
      sudo cp -v /tmp/$release/bat.1 /usr/share/man/man1
      sudo cp -v /tmp/$release/autocomplete/bat.bash /usr/share/bash-completion/completions/
      sudo cp -v /tmp/$release/autocomplete/bat.zsh /usr/share/zsh/site-functions/_bat
    fi
  fi
fi

if ! command -v delta >/dev/null; then
  echo "Install https://github.com/dandavison/delta"
  # See https://github.com/dandavison/delta#installation.
  # Download the tarball from https://github.com/dandavison/delta/releases.
  if ! $PKG_INSTALL git-delta; then
    version=0.14.0
    # https://github.com/dandavison/delta/issues/504#issuecomment-770447508
    release=delta-$version-$(uname -m)-unknown-linux-musl
    curl -fLo /tmp/delta.tar.gz github.com/dandavison/delta/releases/download/$version/$release.tar.gz
    tar xzf /tmp/delta.tar.gz -C /tmp
    sudo install -o root -g root -m 0755 -v /tmp/$release/delta /usr/local/bin
  fi
fi
