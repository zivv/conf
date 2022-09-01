#!/usr/bin/env bash

set -e

if ! command -v zsh >/dev/null; then
  $PKG_INSTALL zsh
  touch ~/.zshrc
  sudo chsh -s $(command -v zsh)
fi

if [[ -z $ZSH ]]; then
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [[ $(uname) == "Darwin" ]]; then
  if ! command -v gsed >/dev/null; then
    $PKG_INSTALL gnu-sed
  fi
  gsed -i 's/^ZSH_THEME\|^plugins=\|^source/#&/g' ~/.zshrc
else
  #sed -i "s/^ZSH_THEME\|^source/#&/g" ~/.zshrc && sed -zi "s/plugins=(\n  git\n)/#plugins=(git)/g" ~/.zshrc
  sed -i 's/^ZSH_THEME\|^plugins=\|^source/#&/g' ~/.zshrc
fi

if ! grep -q ".sh_base" ~/.zshrc; then
  echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >>~/.zshrc
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}
pushd $ZSH_CUSTOM/plugins >/dev/null
for repo in $(grep ZSH_CUSTOM ~/.zsh_local -B1 | grep github.com); do
  if echo $repo | grep -q github.com; then
    name=${repo##*/}
    if [[ ! -d $name ]]; then
      git clone ${repo}.git --depth=1
    fi
    if [[ ! -f $name/$name.plugin.zsh ]]; then
      if ls $name/*.plugin.zsh &>/dev/null; then
        pushd $name >/dev/null
        ln -sv *.plugin.zsh $name.plugin.zsh
        popd >/dev/null
      fi
    fi
  fi
done
popd >/dev/null
