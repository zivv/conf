#!/usr/bin/env bash
#
# To setup through SSH:
#   scp tools/setup_ubuntu.sh $SERVER:/tmp && ssh -t $SERVER '/tmp/setup_ubuntu.sh'

set -ex

sudo apt install -y software-properties-common curl python3-pip tmux xclip tree git vim
pip3 install psutil powerline-status trash-cli

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

if [[ ! -f ~/.dircolors.256dark ]]; then
  curl -Lo ~/.dircolors.256dark \
    https://raw.github.com/seebi/dircolors-solarized/master/dircolors.256dark
fi

# https://github.com/junegunn/fzf
# https://github.com/junegunn/fzf#using-linux-package-managers
# sudo apt install fzf
# NOTE: Key bindings (CTRL-T / CTRL-R / ALT-C) and fuzzy auto-completion may not be enabled by default.
#       Refer to the package documentation for more information. (e.g. apt-cache show fzf)
# https://github.com/junegunn/fzf#using-git
if [[ ! -d ~/.fzf ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --key-bindings --completion --no-update-rc
fi
# https://github.com/sharkdp/fd
if ! command -v fd >/dev/null; then
  sudo apt install fd-find || (
    # https://github.com/sharkdp/fd/releases
    curl -Lo /tmp/fd.deb github.com/sharkdp/fd/releases/download/v8.1.1/fd_8.1.1_amd64.deb
    sudo dpkg -i /tmp/fd.deb
  )
fi
# https://github.com/BurntSushi/ripgrep
if ! command -v rg >/dev/null; then
  curl -Lo /tmp/rg.deb \
    https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
  sudo dpkg -i /tmp/rg.deb
fi
# https://github.com/sharkdp/bat
if ! command -v bat >/dev/null; then
  curl -Lo /tmp/bat.deb \
    https://github.com/sharkdp/bat/releases/download/v0.17.1/bat_0.17.1_amd64.deb
  sudo dpkg -i /tmp/bat.deb
fi
# https://github.com/dandavison/delta
if ! command -v delta >/dev/null; then
  curl -Lo /tmp/delta.tar.gz \
    https://github.com/dandavison/delta/releases/download/0.5.0/delta-0.5.0-x86_64-unknown-linux-gnu.tar.gz
  tar xvf /tmp/delta.tar.gz -C /tmp
  sudo mv /tmp/delta-0.5.0-x86_64-unknown-linux-gnu/delta /usr/local/bin
fi

if ! command -v zsh >/dev/null; then
  sudo apt-get install zsh && touch ~/.zshrc && chsh -s $(command -v zsh)
  curl -Lo ~/.zsh_antigen git.io/antigen
  echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >>~/.zshrc && source ~/.zshrc
fi

if [[ ! -d ~/conf ]]; then
  git clone --depth=1 https://github.com/zivv/conf ~/conf &&
    (cd ~/conf && ./set.sh)
fi

# Recommend: rsync -avhP ~/.vim $SERVER:
