#!/bin/bash

files=(
".bash_base"
".tmux.conf"
".vimrc"
".gitconfig" ".gitignore_global"
".mongorc.js"
)

for file in ${files[@]}
do
  cp $file ~/
done

cp -r vim/* ~/.vim/

if [ -f ~/.at_z_lenovo ]; then
  echo "at z_lenovo"
  cp z_lenovo.bash_local ~/.bash_local
  cp z_lenovo.vimrc_path ~/.vimrc_path
fi

if [ -f ~/.at_z_mac ]; then
  echo "at z_mac"
  cp z_mac.bash_local ~/.bash_local
  cp z_mac.vimrc_local ~/.vimrc_local
fi
