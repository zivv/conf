# Configuration Files

Include configuration files for shell, vim, git, tmux, etc.

Use the existence of file `~/.at_YOUR_PLACE`, checked by `set.sh`, to distinguish and configure different environment.

## Basic configuration

### Color Theme - [Solarized](http://ethanschoonover.com/solarized)

Set terminal to use **Solarized** theme.

#### iTerm2 installation

1. Download [solarized.zip](http://ethanschoonover.com/solarized/files/solarized.zip).
1. Unzip it, change to path `solarized/iterm2-colors-solarized/` and open `Solarized Dark.itermcolors`/`Solarized Light.itermcolors`.
1. Open iTerm2 and set `Preference`->`Profiles`->`Colors`->`Color Presets` as `Solarized Dark`.

### Statusline & Prompt - [Powerline](https://github.com/powerline/powerline)

#### Installation

    pip3 install powerline-status

The following steps are already done in conf files. :)

Or check doc [shell-prompts](https://powerline.readthedocs.org/en/master/usage/shell-prompts.html) for how to set up **shell** prompts and doc [other](https://powerline.readthedocs.org/en/master/usage/other.html) to set up other plugins (like **vim**, **tmux**, **ipython**, etc).

Note that if failed to import powerline in .vimrc, check the result of `:python import sys; print(sys.path)` includes the powerline library path or not (see `import powerline; print(powerline.__file__)`), and add something like `python import sys; sys.path.append('POWERLINE_LIBPATH')` in `.vim_env` if necessary.

_TODO(ziv): Powerline with tmux is not working and the doc is not good enough to solve it. Weird environmental variable (like $POWERLINE_CONFIG_COMMAND, $POWERLINE_COMMAND) in source files. Waiting for updates._

#### [Powerline fonts](https://github.com/powerline/fonts)

Install all Powerline Fonts. See the [documentation](https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation) for details.

    # cd ~/Downloads
    git clone https://github.com/powerline/fonts.git --depth=1 && (cd fonts && ./install.sh)

Then set terminal to use a powerline font. Personally prefer the font named **Sauce Code Powerline** (formerly known as _Source Code Pro_) with **Semibold, 15pt**.

## Set up

### tmux

    # To use powerline for statusline.
    pip3 install psutil

### shell

Read [.sh_base](.sh_base) to set up.

Copied from .sh_base as following:

    Install github.com/seebi/dircolors-solarized
      # cd ~/Downloads
      git clone https://github.com/seebi/dircolors-solarized.git
      cp dircolors-solarized/dircolors.256dark ~/.dircolors.256dark
    Install github.com/andreafrancia/trash-cli
      pip3 install trash-cli

    If using zsh, read .zsh_local to set up.
    If using bash in Linux:
      echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >> ~/.bashrc && source ~/.bashrc
    If using bash in MacOS:
      echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >> ~/.bash_profile && source ~/.bash_profile

Copied from [.zsh_local](.zsh_local) as following:

    Change default shell to zsh
      chsh -s /bin/zsh

    Install [Oh My ZSH](http://ohmyz.sh/) via curl
      sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    Comment some lines in `.zshrc` to accept new settings in this file
      Linux:
        #sed -i "s/^ZSH_THEME\|^source/#&/g" ~/.zshrc && sed -zi "s/plugins=(\n  git\n)/#plugins=(git)/g" ~/.zshrc
        sed -i 's/^ZSH_THEME\|^plugins=\|^source/#&/g' ~/.zshrc
      MacOS:
        brew install gnu-sed
        #gsed -i "s/^ZSH_THEME\|^source/#&/g" ~/.zshrc && gsed -zi "s/plugins=(\n  git\n)/#plugins=(git)/g" ~/.zshrc
        gsed -i 's/^ZSH_THEME\|^plugins=\|^source/#&/g' ~/.zshrc

    Install Fish-like autosuggestions for zsh
      git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

    Set up steps for MacOS
      brew install coreutils

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

    Install https://github.com/Valloric/YouCompleteMe
      # Completer options for install.py
      #   --clang-completer (need cmake, gcc, g++ and python-dev)
      #   --gocode-completer
      cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
    Install https://github.com/Chiel92/vim-autoformat
      brew install clang-format autopep8
      # js-beautify for Javascript and JSON or
      # html-beautify for HTML or css-beautify for CSS.
      # See https://github.com/einars/js-beautify.
      npm install -g js-beautify
      # remark for Markdown. A Javascript based markdown processor.
      # See https://github.com/wooorm/remark.
      npm install -g remark-cli
      # shfmt for Shell. A shell formatter written in Go supporting POSIX Shell.
      # See https://github.com/mvdan/sh.
      go get -u mvdan.cc/sh/cmd/shfmt
      # buildifier for bazel BUILD files.
      # See https://github.com/bazelbuild/buildtools/tree/master/buildifier.
      go get github.com/bazelbuild/buildtools/buildifier
    Install https://github.com/majutsushi/tagbar
      Depend exuberant-ctags
    Install https://github.com/tpope/vim-fugitive
      vim -c "helptags ~/.vim/bundle/vim-fugitive/doc" -c q
    Install https://github.com/fatih/vim-go
      vim -c "GoInstallBinaries" -c q

## Update

Run `ss` or `./set.sh` to set updated files.

## For remote server

Basic configuration setup

    scp for_server/.* REMOTE_SERVER:
    ssh REMOTE_SERVER
    echo "[[ -f ~/.z.sh_base ]] && . ~/.z.sh_base" >> ~/.bashrc
    echo -e 'if filereadable(expand('\''~/.z.vimrc'\''))\n  source ~/.z.vimrc\nendif' >> .vimrc
