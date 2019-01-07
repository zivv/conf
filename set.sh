#!/bin/bash

# Update files by last modification time.

files=(
  ".sh_base" ".bash_local" ".zsh_local"
  ".tmux.conf"
  ".vimrc" ".vim" ".gvimrc"
  ".gitconfig" ".gitignore_global"
)

z=(
  ".sh_env"
  # TODO(ziv): Too old. Need to check update.
  #".mongorc.js"
  #".octaverc"
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
  if [[ $2 =~ "/" ]]; then
    dir=${2%/*}
    if [[ ! -d $dir ]]; then
      mkdir -p $dir
    fi
  fi

  f=$1
  if [[ -f tmp/$f ]]; then
    f=tmp/$f
  fi
  if [[ ! -f $2 || $(diff $f $2) ]]; then
    cp -uv $f $2
  fi
  if [[ $(diff $f $2) ]]; then
    tput setaf 1
    echo "$2 is newer"
    diff -u $f $2
    tput sgr0
  fi
}

# cp_files "prefix" "path1 path2 ..."
function cp_files() {
  for path in $2; do
    if [[ -d $path ]]; then
      for file in $(find $path -type f); do
        cp_file $file $HOME/$file
      done
    else
      file=$path
      if [[ $file =~ "/" ]]; then
        file=${file%/*}/$1${file##*/}
      else
        file=$1$file
      fi
      if [[ -f $file ]]; then
        cp_file $file $HOME/$path
      else
        tput setaf 1
        echo "Can not copy $file"
        tput sgr0
      fi
    fi
  done
}

for loca in ${locas[*]}; do
  if [[ -f ~/.at_$loca ]]; then
    # Your place! \o/
    if [[ $loca =~ ^z_ ]]; then
      # Add author info to global gitconfig
      mkdir -p tmp/
      echo -e "[user]\n  name = ziv\n  email = zivvv0@gmail.com" >tmp/.gitconfig
      cat .gitconfig >>tmp/.gitconfig

      cp_files "" "${z[*]}"
    fi

    eval "loca_files=\$\{$loca\[\*\]\}"
    eval "loca_files=$loca_files"
    cp_files $loca "${loca_files[*]}"
  fi
done

cp_files "" "${files[*]}"
