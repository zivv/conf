#!/bin/bash

# Update files by last modification time.

# file_name|dest_dir
files=(
".sh_base" ".bash_local" ".zsh_local"
".tmux.conf"
".vimrc"
".gitconfig" ".gitignore_global"
".mongorc.js"
"jupyter_notebook_config.py|.jupyter"
".octaverc"
)

locas=(
"z_lenovo"
"z_mac"
"z_ubuntu"
"iost"
)

z_lenovo=(
".sh_local"
".vim_path"
)

z_mac=(
)

z_ubuntu=(
".sh_local"
)

iost=(
".sh_local"
)

for file in ${files[@]}
do
  if [[ ${file} =~ "|" ]]; then
    new_dir=${HOME}/${file#*|}
    if [[ ! -d ${new_dir} ]]; then
      mkdir -p ${new_dir}
    fi
    cp -uv ${file%|*} ${new_dir}
  else
    cp -uv ${file} ~/
  fi
done

for file in $(find vim -type f)
do
  new_file=${HOME}/.vim/${file#vim/}
  if [[ ! -d ${new_file%/*} ]]; then
    mkdir -p ${new_file%/*}
  fi
  cp -uv ${file} ${new_file}
done

for loca in ${locas[@]}
do
  if [[ -f ~/.at_${loca} ]]; then
    # Your place! \o/
    if [[ ${loca} =~ ^z_ ]]; then
      if [[ ! $(diff .gitconfig ~/.gitconfig) ]]; then
        echo "z info -> '$HOME/.gitconfig'"
        echo -e "[user]\n  name = ziv\n  email = zivvv0@gmail.com" > ~/.gitconfig
        cat .gitconfig >> ~/.gitconfig
      fi
    fi

    eval "loca_files=\$\{${loca}\[\@\]\}"
    eval "loca_files=$loca_files"
    for file in ${loca_files[@]}
    do
      cp -uv ${loca}${file} ~/${file}
    done
  fi
done
