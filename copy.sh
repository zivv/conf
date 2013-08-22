#!/bin/bash
cp ~/.bash_base .
cp ~/.gitconfig .
cp ~/.gitignore_global .
cp ~/.tmux.conf .
cp ~/.vimrc .
if [ -f ~/.at_google ]; then
  echo "at google"
  cp ~/.bash_local g.bash_local
  cp ~/.vimrc_local g.vimrc_local
fi
