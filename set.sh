#!/bin/bash

# update files by last modification time

files=(
".sh_base" ".bash_local" ".zsh_local"
".tmux.conf"
".vimrc"
".gitconfig" ".gitignore_global"
".mongorc.js"
"jupyter_notebook_config.py"
)

locas=(
"z_lenovo"
"z_mac"
)

z_lenovo=(
".sh_local"
".vim_path"
)

z_mac=(
".sh_local"
)

for file in ${files[@]}
do
    cp -uv ${file} ~/
done

for file in $(find vim -type f)
do
  new_file=${HOME}'/.vim/'${file#vim/}
  if [[ ! -d ${new_file%/*} ]]; then
    mkdir -p ${new_file%/*}
  fi
  cp -uv ${file} ${new_file}
done

for loca in ${locas[@]}
do
  if [[ -f ~/.at_${loca} ]]; then
    eval "loca_files=\$\{${loca}\[\@\]\}"
    eval "loca_files=$loca_files"
    for file in ${loca_files[@]}
    do
      cp -uv ${loca}${file} ~/${file}
    done
  fi
done
