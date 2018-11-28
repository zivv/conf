# Configure Files

Include configure files for shell, vim, git, tmux, etc.

Use the existence of file `~/.at_YOUR_PLACE`, checked by `set.sh`, to distinguish and configure different environment.

## Basic configuration

### Color Theme - [Solarized](http://ethanschoonover.com/solarized)

Set terminal to use **Solarized** theme. For **iTerm2**, set `Preference`->`Profiles`->`Colors`->`Color Presets` as `Solarized Dark`.

### Statusline & Prompt - [Powerline](https://github.com/powerline/powerline)

#### Installation

    pip3 install powerline-status

The following steps are already done in conf files. :)

Or find doc [shell-prompts](https://powerline.readthedocs.org/en/master/usage/shell-prompts.html) for how to set up shell prompts and doc [other](https://powerline.readthedocs.org/en/master/usage/other.html) to set up other plugins (like vim, tmux, ipython, etc).

Note that if failed to import powerline in .vimrc, check the result of `:python import sys; print(sys.path)` includes the powerline library path or not (see `import powerline; print(powerline.__file__)`), and add something like `python import sys; sys.path.append('POWERLINE_LIBPATH')` in `.vim_env` if necessary.

*TODO(ziv):* Powerline with tmux is not working and the doc is not good enough to solve it. Weird environmental variable (like $POWERLINE\_CONFIG\_COMMAND, $POWERLINE\_COMMAND) in source files. Waiting for updates.

#### [Powerline fonts](https://github.com/powerline/fonts)

Download [zip](https://github.com/powerline/fonts/archive/master.zip) and run `./install.sh` to install all Powerline Fonts or see the [documentation](https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation) for details.

Then set terminal to use a powerline font. Personally prefer the font named **Sauce Code Powerline** (formerly known as *Source Code Pro*) with **Semibold, 15pt**.

## Set up

### shell

Read [.sh\_base](.sh\_base) to set up.

Copied from .sh\_base as following:

    install dircolors
      git clone https://github.com/seebi/dircolors-solarized.git
      cp dircolors-solarized/dircolors.256dark ~/.dircolors.256dark
    install trash-cli
      pip3 install trash-cli

    if in OSX, read z_mac.sh_local to set up.

    if using zsh, read .zsh_local to set up.
    if using bash in Linux:
      echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >> ~/.bashrc && source ~/.bashrc
    if using bash in OSX:
      echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >> ~/.bash_profile && source ~/.bash_profile

Copied from [z\_mac.sh\_local](z\_mac.sh\_local) as following:

    touch ~/.at_z_mac
    brew install coreutils
    source ~/conf/z_mac.sh_local

Copied from [.zsh\_local](.zsh\_local) as following:

    Change default shell to zsh
      chsh -s /bin/zsh

    Install [Oh My ZSH](http://ohmyz.sh/) via curl
      sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    Comment some lines in `.zshrc` to accept new settings in this file
      Linux:
        sed -i 's/^ZSH_THEME\|^source/#&/g' ~/.zshrc && sed -zi 's/plugins=(\n  git\n)/#plugins=(git)/g' ~/.zshrc
      OSX:
        brew install gnu-sed
        gsed -i 's/^ZSH_THEME\|^source/#&/g' ~/.zshrc && gsed -zi 's/plugins=(\n  git\n)/#plugins=(git)/g' ~/.zshrc

    Install Fish-like autosuggestions for zsh
      git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

    Set up shell confs
      echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >> ~/.zshrc && source ~/.zshrc

### config files

Put all config files into right place (create file `~/.at_YOUR_PLACE` if necessary, see [set.sh](set.sh)).

    git clone https://github.com/zivv/conf ~/conf && (cd ~/conf && ./set.sh)

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
    Install vim-autoformat
      Depend clang-format or astyle
    Install tagbar
      Depend exuberant-ctags
    Install fugitive
        vim -c "helptags ~/.vim/bundle/vim-fugitive/doc" -c q
    Install vim-go
        vim -c "GoInstallBinaries" -c q


### tmux

If not work, try `<C-b>:source ~/.tmux.conf<Enter>` when running tmux.

## Update

Run `ss` or `./set.sh` to set updated files.

## For remote server

Basic configuration setup

    scp for_server/.* REMOTE_SERVER:
    ssh REMOTE_SERVER
    echo "[[ -f ~/.z.sh_base ]] && . ~/.z.sh_base" >> ~/.bashrc
    echo -e 'if filereadable(expand('\''~/.z.vimrc'\''))\n  source ~/.z.vimrc\nendif' >> .vimrc
