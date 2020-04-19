#!/usr/bin/env bash
#
# Set up basic configuration files for remote server.

set -ex

SERVER=${SERVER:-$1}
if [[ -z $SERVER ]]; then
  echo "Please provide server address"
  exit 1
fi

if [[ $INIT == 1 ]]; then
  echo "Checking ..."
  ssh $SERVER "which tmux"
  ssh $SERVER "pip3 show powerline-status"
  ssh $SERVER "vim --version | grep +python3"
  echo "Setting up ..."
  _z_powerline_root=$(ssh $SERVER "which pip3 &>/dev/null && pip3 show powerline-status | grep Location | sed 's/Location: //'")
  ssh $SERVER "echo 'export POWERLINE_ROOT=$_z_powerline_root' >> ~/.bashrc"
  ssh $SERVER "echo '[[ -f ~/.z.sh_base ]] && . ~/.z.sh_base' >> ~/.bashrc"
  ssh $SERVER "echo -e 'if filereadable(expand('\''~/.z.vimrc'\''))\n  source ~/.z.vimrc\nendif' >> .vimrc"
fi

echo "Copying files ..."
DIR=$(cd $(dirname $0) && pwd)/for_server
rsync -vcharz --progress -L $DIR/.??* $SERVER:
