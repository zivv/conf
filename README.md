Configure Files
====

Include configure files for `bash, vim, git, tmux`.

Use the existence of file `~/.at_YOUR_PLACE`, checked by `set.sh`, to distinguish and configure different environment.

Run `./set.sh` to set it after each update.


Set up
----

Run following commands to put all configure files into right place(create file `~/.at_YOUR_PLACE` if necessary)(see `set.sh`).

    git clone https://github.com/zivv/conf
    cd conf/
    ./set.sh

For bash

    echo '[[ -f ~/.bash_base ]] && . ~/.bash_base' >> ~/.bashrc
    source ~/.bashrc

For tmux

    Type `<C-b>:source ~/.tmux.conf<Enter>` when running tmux.

For vim

    Read .vimrc to set up.
