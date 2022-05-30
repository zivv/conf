# Configuration Files

Include configuration files for shell, vim, git, tmux, etc.

Use the existence of file `~/.at_YOUR_PLACE`, checked by `set.sh`, to distinguish and configure different environment.

## Init

Init and put all config files into right place (create file `~/.at_YOUR_PLACE` if necessary, see [set.sh](set.sh)):

    curl -fsSL raw.github.com/zivv/conf/HEAD/init.sh | bash

### vim

Check [.vimrc](.vimrc) for your needs.

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

### Fonts

Set the terminal to use a powerline font. Personally prefer the font named **Sauce Code Powerline** (formerly known as _Source Code Pro_) with **Semibold, 15pt**.

## Update

Run `ss` or `./set.sh` to set updated files.

## For remote server

Check [tools/setup-server.sh](tools/setup-server.sh).
