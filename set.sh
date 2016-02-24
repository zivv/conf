#!/bin/bash

# update files by last modification time

files=(
".bash_base"
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
".bash_local"
".vimrc_path"
)

z_mac=(
".bash_local"
".vimrc_local"
)

diff_time() {
  echo $(( $(stat -c %Y $1) - $(stat -c %Y $2) ))
}

for file in ${files[@]}
do
  if [[ $(diff_time ${file} ~/${file}) -gt 0 ]]; then
    cp -v ${file} ~/
  fi
done

for file in $(find vim -type f)
do
  if [[ $(diff_time ${file} ~/.vim/${file#vim/}) -gt 0 ]]; then
    cp -v ${file} ~/.vim/${file#vim/}
  fi
done

for loca in ${locas[@]}
do
  if [ -f ~/.at_${loca} ]; then
    eval "loca_files=\$\{${loca}\[\@\]\}"
    eval "loca_files=$loca_files"
    for file in ${loca_files[@]}
    do
      if [[ $(diff_time ${loca}${file} ~/${file}) -gt 0 ]]; then
        cp -v ${loca}${file} ~/${file}
      fi
    done
  fi
done
