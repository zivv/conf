#!/bin/bash
cp .bash_base ~/
cp .gitconfig ~/
cp .gitignore_global ~/
cp .tmux.conf ~/
cp .vimrc ~/
cp -r skeletons ~/.vim/
if [ -f ~/.at_google ]; then
  echo "at google"
  cp g.bash_local ~/.bash_local
  cp g.vimrc_local ~/.vimrc_local
fi
