# Configure Files

Include configure files for shell, vim, git, tmux, etc.

Use the existence of file `~/.at_YOUR_PLACE`, checked by `set.sh`, to distinguish and configure different environment.

## Basic configuration

### [Powerline](https://github.com/powerline/powerline)

Pip installation

    pip install powerline-status

The following steps are already done in conf files. :)

Or find documentation [shell-prompts](https://powerline.readthedocs.org/en/master/usage/shell-prompts.html) for how to set up shell prompts and [other](https://powerline.readthedocs.org/en/master/usage/other.html) to set up other plugins(include vim, tmux, ipython, etc).

Note that if can not import powerline in .vimrc, check the result of `:python import sys; print(sys.path)` include the powerline library path or not (see `import powerline; print(powerline.__file__)`), and add something like `python import sys; sys.path.append('POWERLINE_LIBPATH')` in .vim_path if necessary.

TODO(ziv): Powerline with tmux is not working and the doc is not good enough to solve it. Weird environmental variable (like $POWERLINE\_CONFIG\_COMMAND, $POWERLINE\_COMMAND) in source files. Waiting for updates.

#### [Powerline fonts](https://github.com/powerline/fonts)

Download [zip](https://github.com/powerline/fonts/archive/master.zip) and run `./install.sh` to install all Powerline Fonts or see the [documentation](https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation) for details.

Usually use the font named **Sauce Code Powerline** (formerly known as *Source Code Pro*).

In OSX, set terminal (Terminal or iTerm) to use powerline fonts.

## Set up

First of all, run following commands to put all configure files into right place (create file `~/.at_YOUR_PLACE` if necessary, see [set.sh](set.sh)).

    git clone https://github.com/zivv/conf ~/conf && (cd ~/conf && ./set.sh)

Then check following steps for different tools.

### vim

Read [.vimrc](.vimrc) to set up.

Copied from .vimrc as following:

    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim -c "PluginInstall" -c q
    git clone https://github.com/zivv/UltiSnips.git ~/.vim/UltiSnips

    Install YouCompleteMe
      Normal command
        cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
      Completer options for install.py
        --clang-completer (need cmake, gcc, g++ and python-dev)
        --gocode-completer
    Install vim-go
        vim -c "GoInstallBinaries" -c q


### tmux

If not work, try `<C-b>:source ~/.tmux.conf<Enter>` when running tmux.

### shell

Read [.sh\_base](.sh\_base) to set up.

Copied from .sh\_base as following:

    install trash-cli
      pip install trash-cli

    if in OSX, read z_mac.sh_local to set up.

    if using zsh, read .zsh_local to set up.
    if using bash in Linux:
      echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >> ~/.bashrc
      echo "BASH_FILE=${HOME}'/.bashrc'" >> ~/.sh_local
    if using bash in OSX:
      echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >> ~/.bash_profile
      echo "BASH_FILE=${HOME}'/.bash_profile'" >> ~/.sh_local

Copied from [z\_mac.sh\_local](z\_mac.sh\_local) as following:

    brew install coreutils

    git clone https://github.com/seebi/dircolors-solarized.git
    cp dircolors-solarized/dircolors.256dark ~/.dircolors.256dark

Copied from [.zsh\_local](.zsh\_local) as following:

    Change default shell to zsh
      chsh -s /bin/zsh

    Install [Oh My ZSH](http://ohmyz.sh/) via curl
      sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    Comment some lines in `.zshrc` to accept new settings in this file
      sed -i _old 's/ZSH_THEME/#ZSH_THEME/g' ~/.zshrc
      sed -i _old 's/plugins=/#plugins/g' ~/.zshrc
      sed -i _old 's/source $ZSH/#source $ZSH/g' ~/.zshrc
      t ~/.zshrc_old

    Install Fish-like autosuggestions for zsh
      git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

    Set up shell confs
      echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >> ~/.zshrc && source ~/.zshrc


## Update

Run `ss` or `./set.sh` to set updated files.

## For remote server

Basic configuration setup

    scp for_server/.* REMOTE_SERVER:
    ssh REMOTE_SERVER
    echo "[[ -f ~/.z.sh_base ]] && . ~/.z.sh_base" >> ~/.bashrc
    echo -e 'if filereadable(expand('\''~/.z.vimrc'\''))\n  source ~/.z.vimrc\nendif' >> .vimrc
