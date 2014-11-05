Configure Files
====

Include configure files for `bash, vim, git, tmux`.

Use the existence of file `~/.at_YOUR_PLACE` - checked by `set.sh` - to distinguish and configure different environment.

Note that `.XXX_local` which keeps local configurations is embedded by the default configure file.

Run `./set.sh` to set it after each update.


Set up
----

    cd conf/
    ./set.sh

    echo '[[ -f ~/.bash_base ]] && . ~/.bash_base' >> ~/.bashrc
    source ~/.bashrc

And then, read .vimrc to set up vim.
