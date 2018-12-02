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
)

z_lenovo=(
  ".sh_local"
  ".vim_path"
)

z_mac=(
  ".vim_local"
)

function cp_file() {
  f=$1
  if [[ -f tmp/$f ]]; then
    f=tmp/$f
  fi
  if [[ $(diff $f $2) ]]; then
    cp -uv $f $2
  fi
  if [[ $(diff $f $2) ]]; then
    echo -e "\033[31m$2 is newer\033[0m"
  fi
}

for loca in ${locas[@]}; do
  if [[ -f ~/.at_${loca} ]]; then
    # Your place! \o/
    if [[ ${loca} =~ ^z_ ]]; then
      # Add author info to global gitconfig
      mkdir -p tmp/
      echo -e "[user]\n  name = ziv\n  email = zivvv0@gmail.com" >tmp/.gitconfig
      cat .gitconfig >>tmp/.gitconfig

      cp_file z.sh_env ~/.sh_env
    fi

    eval "loca_files=\$\{${loca}\[\@\]\}"
    eval "loca_files=$loca_files"
    for file in ${loca_files[@]}; do
      cp_file ${loca}${file} ~/${file}
    done
  fi
done

for file in ${files[@]}; do
  if [[ ${file} =~ "|" ]]; then
    new_dir=${HOME}/${file#*|}
    if [[ ! -d ${new_dir} ]]; then
      mkdir -p ${new_dir}
    fi
    cp_file ${file%|*} ${new_dir}/${file%|*}
  else
    cp_file ${file} ~/${file}
  fi
done

for file in $(find vim -type f); do
  new_file=${HOME}/.vim/${file#vim/}
  if [[ ! -d ${new_file%/*} ]]; then
    mkdir -p ${new_file%/*}
  fi
  cp_file ${file} ${new_file}
done
