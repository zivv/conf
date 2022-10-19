#!/usr/bin/env bash

set -e

if ! command -v zsh >/dev/null; then
  $PKG_INSTALL zsh
  sudo chsh -s $(command -v zsh) $(whoami)
fi

# Install oh-my-zsh.
# https://github.com/ohmyzsh/ohmyzsh#basic-installation
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

# Add custom prompt part.
ZSH=${ZSH:-$HOME/.oh-my-zsh}
if ! grep -q "prompt_custom" $ZSH/themes/agnoster.zsh-theme; then
  sed -i "/build_prompt(/i prompt_custom() {}" $ZSH/themes/agnoster.zsh-theme
  sed -i "/prompt_end$/i \ \ prompt_custom" $ZSH/themes/agnoster.zsh-theme
fi

# Download custom plugins.
ZSH_CUSTOM=${ZSH_CUSTOM:-$ZSH/custom}
pushd $ZSH_CUSTOM/plugins >/dev/null

if [[ ! -f ~/.zsh_local ]]; then
  curl -fsSLo ~/.zsh_local https://raw.github.com/zivv/conf/HEAD/.zsh_local
fi
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

# Fix completions insecurities.
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/compfix.zsh
chmod g-w,o-w $ZSH_CUSTOM/plugins/*

popd >/dev/null
