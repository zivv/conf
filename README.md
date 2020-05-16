# Configuration Files

Include configuration files for shell, vim, git, tmux, etc.

Use the existence of file `~/.at_YOUR_PLACE`, checked by `set.sh`, to distinguish and configure different environment.

## Basic configuration

### Color Theme - [Solarized](http://ethanschoonover.com/solarized)

Set terminal to use **Solarized** theme.

#### iTerm2 installation

1.  Download [solarized.zip](http://ethanschoonover.com/solarized/files/solarized.zip).
2.  Unzip it, change to path `solarized/iterm2-colors-solarized/` and open `Solarized Dark.itermcolors`/`Solarized Light.itermcolors`.
3.  Open iTerm2 and set `Preference`->`Profiles`->`Colors`->`Color Presets` as `Solarized Dark`.

### Statusline & Prompt - [Powerline](https://github.com/powerline/powerline)

#### Installation

    pip3 install powerline-status

The following steps are already done in conf files. :)

Or check doc [shell-prompts](https://powerline.readthedocs.org/en/master/usage/shell-prompts.html) for how to set up **shell** prompts and doc [other](https://powerline.readthedocs.org/en/master/usage/other.html) to set up other plugins (like **vim**, **tmux**, **ipython**, etc).

Note that if failed to import powerline in .vimrc, check the result of `:python import sys; print(sys.path)` includes the powerline library path or not (see `import powerline; print(powerline.__file__)`), and add something like `python import sys; sys.path.append('POWERLINE_LIBPATH')` in `.vim_env` if necessary.

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

    Install https://github.com/ryanoasis/vim-devicons
      Install https://github.com/ryanoasis/nerd-fonts
        MacOS - https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts
          brew tap caskroom/fonts && brew cask install font-hack-nerd-font
          # Then open iTerm2 and set `Preference`->`Profiles`->`Text`->
          # `Non-ASCII Font` as `Hack Nerd Font`.
        Linux - https://github.com/ryanoasis/nerd-fonts#linux
    Install https://github.com/Chiel92/vim-autoformat
      MacOS:
        brew install clang-format autopep8
      Linux:
        sudo apt-get install clang-format python3-pip && pip3 install autopep8
      # Bazel BUILD - buildifier.
      # See https://github.com/bazelbuild/buildtools/tree/master/buildifier.
      go get github.com/bazelbuild/buildtools/buildifier
      # Shell - shfmt. A shell formatter written in Go supporting POSIX Shell.
      # See https://github.com/mvdan/sh.
      go get -u mvdan.cc/sh/cmd/shfmt
      # Markdown - remark. A Javascript based markdown processor.
      # See https://github.com/wooorm/remark.
      npm install -g remark-cli
      # JSON - fixjson. A JSON fixer for humans using (relaxed) JSON5.
      # See https://github.com/rhysd/fixjson.
      npm install -g fixjson
    Install https://github.com/Valloric/YouCompleteMe
      # Completer options for install.py
      #   --clang-completer (need cmake, gcc, g++ and python-dev)
      #   --gocode-completer
      #   --ts-completer (JavaScript and TypeScript support)
      #   --all (with everything enabled except --clangd-completer)
      cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
    Install https://github.com/majutsushi/tagbar
      Depend on Exuberant Ctags or Universal Ctags (See https://ctags.io/).
      MacOS:
        brew install --HEAD universal-ctags/universal-ctags/universal-ctags
      Linux:
        snap install universal-ctags
      # Javascript - jsctags.
      # See https://github.com/sergioramos/jsctags.
      npm install -g jsctags
    Install https://github.com/dense-analysis/ale
      # Vim - vint. A vim script language lint.
      # See https://github.com/Kuniwak/vint.
      pip3 install vim-vint
      # Protobuf - protoc-gen-lint. A plug-in for protobufs compiler to lint.
      # See https://github.com/ckaznocha/protoc-gen-lint.
      go get github.com/ckaznocha/protoc-gen-lint
    Install https://github.com/tpope/vim-fugitive
      vim -c "helptags ~/.vim/bundle/vim-fugitive/doc" -c q
    Install https://github.com/fatih/vim-go
      vim -c "GoInstallBinaries" -c q

## Update

Run `ss` or `./set.sh` to set updated files.

## For remote server

Assume the server address is `xxx`, run `INIT=1 ./set_server.sh xxx` to init and `./set_server.sh xxx` to update.
