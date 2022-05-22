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

The following steps are already done in conf files. :)

#### Installation

    pip3 install powerline-status

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

Put all config files into right place (create file `~/.at_YOUR_PLACE` if necessary, see [set.sh](set.sh)) and init all:

    curl -fsSL https://raw.github.com/zivv/conf/HEAD/init.sh | bash

### vim

Check [.vimrc](.vimrc) for your needs.

## Update

Run `ss` or `./set.sh` to set updated files.

## For remote server

Check [tools/setup-server.sh](tools/setup-server.sh).
