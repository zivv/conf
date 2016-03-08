# Configure Files

Include configure files for shell, vim, git, tmux, etc.

Use the existence of file `~/.at_YOUR_PLACE`, checked by `set.sh`, to distinguish and configure different environment.

## Basic configuration

### [Powerline](https://github.com/powerline/powerline)

Pip installation

    pip install powerline-status

The following steps are already done in conf files. :)

Or find documentation [shell-prompts](https://powerline.readthedocs.org/en/master/usage/shell-prompts.html) for how to set up shell prompts and [other](https://powerline.readthedocs.org/en/master/usage/other.html) to set up other plugins(include vim, tmux, ipython, etc).

TODO(ziv): Powerline with tmux is not working and the doc is not good enough to solve it. Weird environmental variable (like $POWERLINE\_CONFIG\_COMMAND, $POWERLINE\_COMMAND) in source files. Waiting for updates.

#### [Powerline fonts](https://github.com/powerline/fonts)

Download [zip](https://github.com/powerline/fonts/archive/master.zip) and run `./install.sh` to install all Powerline Fonts or see the [documentation](https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation) for details.

In OSX, set terminal(Terminal or iTerm) to use powerline fonts.

## Set up

First of all, run following commands to put all configure files into right place (create file `~/.at_YOUR_PLACE` if necessary, see [set.sh](set.sh)).

    git clone https://github.com/zivv/conf ~/conf && (cd ~/conf && ./set.sh)

Then check following steps for different tools.

### vim

Read [.vimrc](.vimrc) to set up.

### tmux

If not work, try `<C-b>:source ~/.tmux.conf<Enter>` when running tmux.

### shell

Read [.sh_base](.sh_base) to set up.

## Update

Run `ss` or `./set.sh` to set updated files.

## For remote server

Basic configuration setup

    scp for_server/.* REMOTE_SERVER:
    ssh REMOTE_SERVER
    echo "[[ -f ~/.z.sh_base ]] && . ~/.z.sh_base" >> ~/.bashrc
    echo -e 'if filereadable(expand('\''~/.z.vimrc'\''))\n  source ~/.z.vimrc\nendif' >> .vimrc