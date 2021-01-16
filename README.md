# Configuration Files

Include configuration files for shell, vim, git, tmux, etc.

Use the existence of file `~/.at_YOUR_PLACE`, checked by `set.sh`, to distinguish and configure different environment.

## Basic configuration

### Color Theme - [Solarized](http://ethanschoonover.com/solarized)

Set terminal to use **Solarized** theme.

#### iTerm2

1.  Download [solarized.zip](http://ethanschoonover.com/solarized/files/solarized.zip).
2.  Unzip it, change to path `solarized/iterm2-colors-solarized/` and open `Solarized Dark.itermcolors`/`Solarized Light.itermcolors`.
3.  Open iTerm2 and set `Preference`->`Profiles`->`Colors`->`Color Presets` as `Solarized Dark`.

#### GNOME Terminal

Open `Terminal`->`Preferences`->`Colors`, set `Built-in schemes` under `Text and Background Color` as
`Solarized dark` and `Built-in schemes` under `Palette` as `Solarized`.

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

OR just to install **Source Code Pro** only:

    mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts && curl -fLo "Source Code Pro Semibold for Powerline.otf" https://github.com/powerline/fonts/raw/master/SourceCodePro/Source%20Code%20Pro%20Semibold%20for%20Powerline.otf && fc-cache -f -v

## Set up

### tmux

    # To use powerline for statusline.
    pip3 install psutil

### shell

Read [.sh_base](.sh_base) to set up.

Copied from .sh_base as following:

    Install github.com/seebi/dircolors-solarized
      curl -Lo ~/.dircolors.256dark \
        https://raw.github.com/seebi/dircolors-solarized/master/dircolors.256dark

    Set up steps for MacOS
      brew install bash coreutils

    If using zsh, read .zsh_local to set up.
    If using bash:
      echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >> ~/.bashrc && source ~/.bashrc

    Recommended tools:
      Install https://github.com/andreafrancia/trash-cli
        pip3 install trash-cli
      Install https://github.com/junegunn/fzf
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --key-bindings --completion --no-update-rc
      Install https://github.com/sharkdp/fd
        See https://github.com/sharkdp/fd#installation.
        Try `fd-find` / `fd` for package manager or check https://github.com/sharkdp/fd/releases.
      Install https://github.com/BurntSushi/ripgrep
        See https://github.com/BurntSushi/ripgrep#installation.
        Try `ripgrep` for package manager or check https://github.com/BurntSushi/ripgrep/releases.
      Install https://github.com/sharkdp/bat
        See https://github.com/sharkdp/bat#installation.
        Try `bat` for package manager or check https://github.com/sharkdp/bat/releases.
      Install https://github.com/dandavison/delta
        See https://github.com/dandavison/delta#installation.
        Download the tarball from https://github.com/dandavison/delta/releases.

Copied from [.zsh_local](.zsh_local) as following:

    Install zsh and change default shell
      sudo apt-get install zsh && touch ~/.zshrc && chsh -s $(which zsh)

    Install https://github.com/zsh-users/antigen
      curl -Lo ~/.zsh_antigen git.io/antigen

    Set up shell confs
      echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >>~/.zshrc && source ~/.zshrc

### config files

Put all config files into right place (create file `~/.at_YOUR_PLACE` if necessary, see [set.sh](set.sh)).

    git clone https://github.com/zivv/conf ~/conf && (cd ~/conf && ./set.sh)

### vim

Read [.vimrc](.vimrc) to set up.

Copied from .vimrc as following:

    The installation for vim-plug and all plugins will be auto triggered.

    Install https://github.com/ryanoasis/vim-devicons
      Install https://github.com/ryanoasis/nerd-fonts
        MacOS - https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts
          brew tap caskroom/fonts && brew cask install font-hack-nerd-font
          # Then open iTerm2 and set `Preference`->`Profiles`->`Text`->
          # `Non-ASCII Font` as `Hack Nerd Font`.
        Linux - https://github.com/ryanoasis/nerd-fonts#linux
    Install https://github.com/Chiel92/vim-autoformat
      MacOS:
        brew install clang-format python3 && pip3 install black
      Linux:
        sudo apt-get install clang-format python3-pip && pip3 install black
      # Bazel BUILD - buildifier.
      # See https://github.com/bazelbuild/buildtools/tree/master/buildifier.
      go get github.com/bazelbuild/buildtools/buildifier
      # Shell - shfmt. A shell formatter written in Go supporting POSIX Shell.
      # See https://github.com/mvdan/sh#shfmt.
      GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt
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
      cd ~/.vim/plugged/YouCompleteMe && ./install.py --clangd-completer
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
      # Python - flake8. Your Tool For Style Guide Enforcement.
      # See https://flake8.pycqa.org/.
      pip3 install flake8 flake8-awesome

## Update

Run `ss` or `./set.sh` to set updated files.

## For remote server

Assume the server address is `xxx`, run `INIT=1 ./set_server.sh xxx` to init and `./set_server.sh xxx` to update.
