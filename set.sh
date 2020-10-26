#!/usr/bin/env bash
#
# Set up configuration files.

set -e

# Internal Field Separator.
# Use newline instead of default setting which includes space.
IFS=$(echo -en "\n\b")

files=(
  ".sh_auto" ".sh_base" ".sh_custom"
  ".bash_local" ".zsh_local"
  ".tmux.conf"
  ".vimrc" ".vim" ".gvimrc"
  ".gitconfig" ".gitignore_global"
  ".config/flake8"
)

z=(
  ".sh_env"
  ".gitconfig_local"
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

declare -A colors=(
  [black]=0 [red]=1 [green]=2 [yellow]=3 [blue]=4 [magenta]=5 [cyan]=6 [white]=7
)
function color() {
  tput setaf ${colors[$1]} 2>/dev/null || true
  "${@:2}"
  tput sgr0 2>/dev/null || true
}

# Auto generated variables to speed up shell initialization.
function auto() {
  mkdir -p tmp/
  >tmp/.sh_auto
  for line in $(cat .sh_auto); do
    if [[ $line =~ ^#.* ]]; then
      # Copy comments.
      echo $line >>tmp/.sh_auto
    else
      key=${line%%=*}
      value=${line#*=}
      # Add comments.
      echo "# $value" >>tmp/.sh_auto

      color green echo "Processing: $line"
      eval "value=$value"
      color green echo "Get value : $value"
      eval "$key=$value"
      # Add the variable.
      echo "$key=$value" >>tmp/.sh_auto
    fi
  done
  color blue echo "File tmp/.sh_auto has been generated"
}
if [[ .sh_auto -nt tmp/.sh_auto ]]; then
  auto
fi

function cp_file() {
  f=$1
  if [[ -f tmp/$f ]]; then
    f=tmp/$f
  fi
  if [[ ! -f $f ]]; then
    color red echo >&2 "File does not exist: $(pwd)/$f"
    return 1
  fi

  if [[ $2 =~ "/" ]]; then
    dir=${2%/*}
    if [[ ! -d $dir ]]; then
      mkdir -p $dir
    fi
  fi

  if [[ ! -f $2 || $(diff $f $2) ]]; then
    # Verbose and copy only when $f is newer or $2 is missing.
    color blue cp -uv $f $2
  fi
  if [[ $(diff $f $2) ]]; then
    color yellow echo "$2 is newer"
    color green diff -u $f $2
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
      cp_file $file $HOME/$path
    fi
  done
}

for loca in ${locas[*]}; do
  if [[ -f ~/.at_$loca ]]; then
    # Your place! \o/
    if [[ $loca =~ ^z_ ]]; then
      cp_files "" "${z[*]}"
    fi

    eval "loca_files=\$\{$loca\[\*\]\}"
    eval "loca_files=$loca_files"
    cp_files $loca "${loca_files[*]}"
  fi
done

if [[ -f ~/.gitconfig_local ]]; then
  if [[ .gitconfig -nt tmp/.gitconfig ]] ||
    [[ ~/.gitconfig_local -nt tmp/.gitconfig ]]; then
    mkdir -p tmp/
    cat .gitconfig >tmp/.gitconfig
    cat ~/.gitconfig_local >>tmp/.gitconfig
  fi
fi
if [[ -f ~/.gitignore_local ]]; then
  if [[ .gitignore_global -nt tmp/.gitignore_global ]] ||
    [[ ~/.gitignore_local -nt tmp/.gitignore_global ]]; then
    mkdir -p tmp/
    cat .gitignore_global >tmp/.gitignore_global
    echo -e "\n# Local git-ignore items in ~/.gitignore_local" \
      >>tmp/.gitignore_global
    cat ~/.gitignore_local >>tmp/.gitignore_global
  fi
fi

cp_files "" "${files[*]}"
